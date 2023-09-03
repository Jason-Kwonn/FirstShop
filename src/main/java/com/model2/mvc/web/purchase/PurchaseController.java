package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpSession;

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
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.web.product.ProductController;
import com.model2.mvc.web.user.UserController;

@Controller
public class PurchaseController {
	
	//Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	//Constructor
	public PurchaseController() {
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
		
	//Method
	@RequestMapping("/addPurchaseView.do")
	public String addPurchaseView(@RequestParam("prodNo") int prodNo, 
							@ModelAttribute Purchase purchase, HttpSession session, Model model) throws Exception {
		
		System.out.println("/addPurchaseView.do?prodNo=" + String.valueOf(prodNo));
		
		//Business Logic
//		product = productService.getProduct(prodNo);
		User user = (User) session.getAttribute("user");
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		
		model.addAttribute("purchase", purchase);
		
		System.out.println(purchase.toString());
		
		return "forward:/purchase/addPurchaseView.jsp";
		
	}
	
	@RequestMapping("/addPurchase.do")
	public String addPurchase(@ModelAttribute("purchase") Purchase purchase, @ModelAttribute Product product, @ModelAttribute User user) throws Exception {
		
		System.out.println("/addPurchase.do");
		
		//Business Logic
		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		
		purchaseService.addPurchase(purchase);
		
		System.out.println(purchase.toString());
		
		return "forward:/purchase/addPurchaseResult.jsp";
		
	}
	
	@RequestMapping("/getPurchase.do")
	public String getPurchase(@RequestParam("tranNo") int tranNo, HttpSession session, Model model) throws Exception {
		
		System.out.println("/getPurchase.do");
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		if (purchase.getPaymentOption().trim().equals("1")) {
			purchase.setPaymentOption("현금구매");
		} else if (purchase.getPaymentOption().trim().equals("2")) {
			purchase.setPaymentOption("신용구매");
		}
		
		User user = (User)session.getAttribute("user");
		purchase.setBuyer(user);
		
		purchase.setDlvyDate(purchase.getDlvyDate().substring(0, 10));
		
		model.addAttribute("purchase", purchase);
		
		System.out.println(purchase.toString());
		
		return "forward:/purchase/getPurchase.jsp";
		
	}
	
	@RequestMapping("/listPurchase.do")
	public String getPurchaseList(@ModelAttribute Search search, Model model) throws Exception {
		
		System.out.println("/listPurchase.do");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		//Business Logic 
		Map<String, Object> map = purchaseService.getPurchaseList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		//Model 과 View 연결 
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/purchase/listPurchase.jsp";
		
	}
	
	@RequestMapping("/updatePurchaseView.do")
	public String updatePurchaseView(@RequestParam int tranNo, @ModelAttribute Purchase purchase, Model model) throws Exception {
		
		System.out.println("/updatePurchaseView.do?tranNo=" + String.valueOf(tranNo));
		
		//Business Logic
		purchase = purchaseService.getPurchase(tranNo);
		
		purchase.setDlvyDate(purchase.getDlvyDate().replace("-", "").substring(0, 8));
		
		model.addAttribute("purchase", purchase);
		
		System.out.println(purchase.toString());
		
		return "forward:/purchase/updatePurchase.jsp";
		
	}
	
	@RequestMapping("/updatePurchase.do")
	public String updatePurchase(@RequestParam int tranNo, @ModelAttribute Purchase purchase) throws Exception {
		
		System.out.println("/updatePurchase.do?tranNo=" + String.valueOf(tranNo));
		
		//Business Logic
		purchaseService.updatePurchase(purchase);
		
		System.out.println(purchase.toString());
		
		return "redirect:/getPurchase.do?tranNo=" + tranNo;
		
	}
	
	@RequestMapping("/updateTranCodeByProd.do")
	public String updateTranCodeByProd(@RequestParam int prodNo, @RequestParam String tranCode, 
										@ModelAttribute Purchase purchase) throws Exception {
		
		System.out.println("/updateTranCodeByProd.do");
		
		//Business Logic
		Product product = new Product();
		product.setProdNo(prodNo);
		purchase.setPurchaseProd(product);
		purchase.setTranCode(tranCode);
		
		System.out.println(purchase);
		
		purchaseService.updateTranCodeByProd(purchase);
		
		return "redirect:/listProduct.do?menu=manage";
		
	}
	
	@RequestMapping("/updateTranCode.do")
	public String updateTranCode(@RequestParam int tranNo, @RequestParam String tranCode, 
										@ModelAttribute Purchase purchase) throws Exception {
		
		System.out.println("/updateTranCode.do");
		
		//Business Logic
		
		purchase.setTranNo(tranNo);
		purchase.setTranCode(tranCode);
		
		System.out.println(purchase);
		
		purchaseService.updateTranCode(purchase);
		
		return "redirect:/listPurchase.do";
		
	}
	
	
	
}
