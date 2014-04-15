package hc.basic.mvc;

import hc.basic.dto.Tag;
import hc.domain.Product;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyFactory;

@Controller
@RequestMapping(value = "/event")
public class HcEventController {

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest request, Locale locale) throws Exception {

		return "home";

	}
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(Model model, HttpServletRequest request, Locale locale) throws Exception {

		return "test";

	}	

	@RequestMapping(value = "/testTags", method = RequestMethod.GET)
	public @ResponseBody
	List<Tag> getTags(@RequestParam String tagName) {
		tagName = tagName.toLowerCase();
		List<Tag> data = new ArrayList<Tag>();
		data.add(new Tag(1, "ruby"));
		data.add(new Tag(2, "rails"));
		data.add(new Tag(3, "c / c++"));
		data.add(new Tag(4, ".net"));
		data.add(new Tag(5, "python"));
		data.add(new Tag(6, "java"));
		data.add(new Tag(7, "javascript"));
		data.add(new Tag(8, "jscript"));

		List<Tag> result = new ArrayList<Tag>();
		for (Tag t : data) {
			if (t.tagName.startsWith(tagName)) {
				result.add(t);
			}
		}
		return result;

	}
	
	@Autowired private ObjectifyFactory objectifyFactory;
	
	@RequestMapping(value = "/addProduct", method = RequestMethod.GET)
	public @ResponseBody
	String addProduct(Model model) {		
		Objectify ofy = objectifyFactory.begin();
		Product p = new Product();
		p.setName("cmktt");
		p.setDescription("d");
		ofy.put(p);
		return "Success";

	}	
		
	@RequestMapping(value = "/getProduct", method = RequestMethod.GET)
	public @ResponseBody
	Product getProduct(@RequestParam String tagName) {
		Objectify ofy = objectifyFactory.begin();
		
		Product p = ofy.query(Product.class).filter("name", tagName).get();	

		return p;
	}		

}
