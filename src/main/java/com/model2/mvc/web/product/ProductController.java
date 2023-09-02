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
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
public class ProductController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping("/addProductView.do")
	public String addProductView(@RequestParam("menu") String menu) throws Exception {
		
		System.out.println("/addProductView.do?menu=" + menu);
		
		return "redirect:/product/addProductView.jsp";
	}
	
	@RequestMapping("/addProduct.do")
	public String addProduct(@ModelAttribute Product product) throws Exception {
		
		System.out.println("/addProduct.do" + product.toString());
		// Business Logic
		
		// 날짜 '-' 단위 null String 으로 변경 
		String tempManuDate = product.getManuDate().replace("-", "");
		product.setManuDate(tempManuDate);
				
		productService.addProduct(product);
		
		
		return "redirect:/product/addProductView.jsp";
	}
	
	@RequestMapping("/getProduct.do")
	public String getProduct(@RequestParam("prodNo") int prodNo, Model model, 
							HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/getProduct.do");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		//Model 과 View 연결 
		model.addAttribute("product", product);
		
		// 쿠키에서 기존의 상품 번호 리스트를 가져옴
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
        
        // 쿠키 생성
        if ( ! isHistoryFound && prodNo != 0){
        	Cookie newCookie = new Cookie("history", java.net.URLEncoder.encode(request.getParameter("prodNo"), "euc-kr"));
        	newCookie.setMaxAge(60 * 5); // 쿠키 유효 기간 설정 (ex. 60초 * 5 = 5분)
        	response.addCookie(newCookie);
        	System.out.println("newCookie : " + newCookie.getValue());
        }
		
		
		return "forward:/product/getProduct.jsp";
		
	}
	
	@RequestMapping("/listProduct.do")
	public String getProductList(@RequestParam("menu") String menu, @ModelAttribute("search") Search search, Model model) throws Exception {
		
		System.out.println("/listProduct.do");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		//Business Logic 수행 
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		//Model 과 View 연결 
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}
	
	@RequestMapping("/updateProductView.do")
	public String updateProductView(@ModelAttribute("prodNo") int prodNo, Model model) throws Exception {
		
		System.out.println("/updateProductView.do");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		//Model 과 View 연결 
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
		
	}
	
	@RequestMapping("/updateProduct.do")
	public String updateProduct(@ModelAttribute("product") Product product, Model model) throws Exception{
		
		System.out.println("/updateProduct.do");
		//Business Logic
		productService.updateProduct(product);
		
		return "redirect:/getProduct.do?prodNo="+ product.getProdNo();
	}
	
} // end of class
