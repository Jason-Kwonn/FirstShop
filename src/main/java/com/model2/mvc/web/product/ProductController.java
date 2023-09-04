package com.model2.mvc.web.product;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
//	@RequestMapping("/addProductView.do")
//	public String addProductView(@RequestParam("menu") String menu) throws Exception {
	@RequestMapping(value="addProduct", method=RequestMethod.GET)
	public String addProduct(@RequestParam("menu") String menu) throws Exception {
		
		System.out.println("/product/addProduct : GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	
//	@RequestMapping("/addProduct.do")
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct(@ModelAttribute Product product) throws Exception {
		
		System.out.println("/product/addProduct : POST");
		// Business Logic
		
		// ��¥ '-' ���� null String ���� ���� 
		String tempManuDate = product.getManuDate().replace("-", "");
		product.setManuDate(tempManuDate);
				
		productService.addProduct(product);
		
		
		return "redirect:/product/addProductView.jsp";
	}
	
//	@RequestMapping("/getProduct.do")
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public String getProduct(@RequestParam("prodNo") int prodNo, Model model, 
							HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		//Model �� View ���� 
		model.addAttribute("product", product);
		
		// ��Ű���� ������ ��ǰ ��ȣ ����Ʈ�� ������
        Cookie[] cookies = request.getCookies();
        boolean isHistoryFound = false;
        
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("history")) {
                	isHistoryFound = true;
                	String history = cookie.getValue();
                	String noDuplication = history.replace(request.getParameter("prodNo"), "");
                	String historyProdNo = noDuplication + "/" + request.getParameter("prodNo");
                	
                    cookie.setValue(historyProdNo);
                    response.addCookie(cookie);
                    System.out.println("History Value: " + historyProdNo);
                    System.out.println("cookie : " + cookie.getValue());
                    System.out.println("encode : "+URLEncoder.encode("/", "euc-kr"));
                    break;
                }
            }
        }
        
        // ��Ű ����
        if ( ! isHistoryFound && prodNo != 0){
        	Cookie newCookie = new Cookie("history", java.net.URLEncoder.encode(request.getParameter("prodNo"), "euc-kr"));
        	newCookie.setMaxAge(60 * 5); // ��Ű ��ȿ �Ⱓ ���� (ex. 60�� * 5 = 5��)
        	response.addCookie(newCookie);
        	System.out.println("newCookie : " + newCookie.getValue());
        }
		
		
		return "forward:/product/getProduct.jsp";
		
	}
	
//	@RequestMapping("/listProduct.do")
	@RequestMapping(value="listProduct")
	public String getProductList(@RequestParam("menu") String menu, @ModelAttribute("search") Search search, Model model) throws Exception {
		
		System.out.println("/product/listProduct : GET / POST");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		//Business Logic ���� 
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		//Model �� View ���� 
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}
	
//	@RequestMapping("/updateProductView.do")
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProductView(@ModelAttribute("prodNo") int prodNo, Model model) throws Exception {
		
		System.out.println("/product/updateProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		//Model �� View ���� 
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
		
	}
	
//	@RequestMapping("/updateProduct.do")
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct(@ModelAttribute("product") Product product, Model model) throws Exception{
		
		System.out.println("/product/updateProduct : POST");
		//Business Logic
		productService.updateProduct(product);
		
		return "redirect:/getProduct.do?prodNo="+ product.getProdNo();
	}
	
} // end of class
