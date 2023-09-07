package com.model2.mvc.web.product;

import java.io.File;
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
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
	public String addProduct(@ModelAttribute Product product, @RequestParam("files") MultipartFile[] files) throws Exception {
		
		System.out.println("/product/addProduct : POST");
		// Business Logic
		String resultFileName = "";
		
		for(MultipartFile file : files) {
			if(!file.isEmpty()) {
				String realFileName = StringUtils.cleanPath(file.getOriginalFilename());
				String uploadDir = "/Users/soonjaekwon/miniproject/09.Model2MVCShop(jQuery)/src/main/webapp/images/uploadFiles/";
				File uploadFile = new File(uploadDir, realFileName);
				file.transferTo(uploadFile);
				
				if (!resultFileName.isEmpty()) {
		            // resultFileName이 비어있지 않으면 ','를 추가
		            resultFileName += ",";
		        }
		        resultFileName += realFileName;
				
				product.setFileName(resultFileName);
				
				System.out.println("Uploaded file name: " + realFileName);
			
			} else {
				System.out.println("404 : File Not Found");
			}
		}
		
		// 날짜 '-' 단위 null String 으로 변경 
		String tempManuDate = product.getManuDate().replace("-", "");
		product.setManuDate(tempManuDate);
		
		
				
		productService.addProduct(product);
		
		
		return "redirect:/product/addProductView.jsp";
	}
	
//	@RequestMapping("/getProduct.do")
	@RequestMapping(value="getProduct")
	public String getProduct(@RequestParam("prodNo") int prodNo, Model model, 
							HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/product/getProduct");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		
		String[] fileNames = product.getFileName().split(",");
		
		product.setFileNames(fileNames);
		
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
	
//	@RequestMapping("/listProduct.do")
	@RequestMapping(value="listProduct")
	public String getProductList(@ModelAttribute("search") Search search, Model model) throws Exception {
		
		System.out.println("/product/listProduct : GET / POST");
		
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
		
		return "forward:/product/listProduct.jsp";
	}
	
//	@RequestMapping("/updateProductView.do")
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProductView(@ModelAttribute("prodNo") int prodNo, Model model) throws Exception {
		
		System.out.println("/product/updateProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		//Model 과 View 연결 
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
		
	}
	
//	@RequestMapping("/updateProduct.do")
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct(@ModelAttribute("product") Product product,	@RequestParam("file") MultipartFile file) throws Exception{
		
		System.out.println("/product/updateProduct : POST");
		//Business Logic
		
		if(!file.isEmpty()) {
			String realFileName = StringUtils.cleanPath(file.getOriginalFilename());
			String uploadDir = "/Users/soonjaekwon/miniproject/09.Model2MVCShop(jQuery)/src/main/webapp/images/uploadFiles/";
			File uploadFile = new File(uploadDir, realFileName);
			file.transferTo(uploadFile);
			
			product.setFileName(realFileName);
			System.out.println(file.getOriginalFilename());
		} else {
			System.out.println("404 : File Not Found");
		}
		
		// 날짜 '-' 단위 null String 으로 변경 
		String tempManuDate = product.getManuDate().replace("-", "");
		product.setManuDate(tempManuDate);
		
		productService.updateProduct(product);
		
		return "redirect:/product/updateProduct?prodNo="+ product.getProdNo();
	}
	
} // end of class
