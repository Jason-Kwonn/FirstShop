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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

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
@RequestMapping("/purchase/*")
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
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
		
	//Method
//	@RequestMapping("/addPurchaseView.do")
	@RequestMapping(value="addPurchase", method=RequestMethod.GET)
	public ModelAndView addPurchaseView(@RequestParam("prodNo") int prodNo, 
							@ModelAttribute Purchase purchase, HttpSession session, ModelAndView modelAndView) throws Exception {
		
		System.out.println("/purchase/addPurchase : GET");
		
		//Business Logic
//		product = productService.getProduct(prodNo);
		User user = (User) session.getAttribute("user");
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		
		modelAndView.setViewName("/purchase/addPurchase");
		modelAndView.addObject("purchase", purchase);
		
		System.out.println(purchase.toString());
		
		return modelAndView;
		
	}
	
//	@RequestMapping("/addPurchase.do")
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public ModelAndView addPurchase(@ModelAttribute("purchase") Purchase purchase, @ModelAttribute Product product, 
									@ModelAttribute User user, ModelAndView modelAndView) throws Exception {
		
		System.out.println("/purchase/addPurchase : POST");
		
		//Business Logic
		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		
		
		purchaseService.addPurchase(purchase);
		
		return modelAndView;
		
	}
	
//	@RequestMapping("/getPurchase.do")
	@RequestMapping(value="getPurchase", method=RequestMethod.GET)
	public String getPurchase(@RequestParam("tranNo") int tranNo, HttpSession session, Model model) throws Exception {
		
		System.out.println("/purchase/getPurchase : GET");
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
	
//	@RequestMapping("/listPurchase.do")
	@RequestMapping(value="listPurchase")
	public String getPurchaseList(@ModelAttribute Search search, Model model) throws Exception {
		
		System.out.println("/purchase/listPurchase : GET / POST");
		
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
	
//	@RequestMapping("/updatePurchaseView.do")
	@RequestMapping(value="updatePurchase", method=RequestMethod.GET)
	public String updatePurchaseView(@RequestParam int tranNo, @ModelAttribute Purchase purchase, Model model) throws Exception {
		
		System.out.println("/purchase/updatePurchase : GET");
		
		//Business Logic
		purchase = purchaseService.getPurchase(tranNo);
		
		purchase.setDlvyDate(purchase.getDlvyDate().replace("-", "").substring(0, 8));
		
		model.addAttribute("purchase", purchase);
		
		System.out.println(purchase.toString());
		
		return "forward:/purchase/updatePurchase.jsp";
		
	}
	
//	@RequestMapping("/updatePurchase.do")
	@RequestMapping(value="updatePurchase", method=RequestMethod.POST)
	public String updatePurchase(@RequestParam int tranNo, @ModelAttribute Purchase purchase) throws Exception {
		
		System.out.println("/purchase/updatePurchase : POST");
		
		//Business Logic
		purchaseService.updatePurchase(purchase);
		
		System.out.println(purchase.toString());
		
		return "redirect:/getPurchase.do?tranNo=" + tranNo;
		
	}
	
//	@RequestMapping("/updateTranCodeByProd.do")
	@RequestMapping(value="updateTranCodeByProd", method=RequestMethod.GET)
	public String updateTranCodeByProd(@RequestParam int prodNo, @RequestParam String tranCode, 
										@ModelAttribute Purchase purchase) throws Exception {
		
		System.out.println("/purchase/updateTranCodeByProd : GET");
		
		//Business Logic
		Product product = new Product();
		product.setProdNo(prodNo);
		purchase.setPurchaseProd(product);
		purchase.setTranCode(tranCode);
		
		System.out.println(purchase);
		
		purchaseService.updateTranCodeByProd(purchase);
		
		return "redirect:/listProduct.do?menu=manage";
		
	}
	
//	@RequestMapping("/updateTranCode.do")
	@RequestMapping(value="updateTranCode", method=RequestMethod.POST)
	public String updateTranCode(@RequestParam int tranNo, @RequestParam String tranCode, 
										@ModelAttribute Purchase purchase) throws Exception {
		
		System.out.println("/purchase/updateTranCode : POST");
		
		//Business Logic
		
		purchase.setTranNo(tranNo);
		purchase.setTranCode(tranCode);
		
		System.out.println(purchase);
		
		purchaseService.updateTranCode(purchase);
		
		return "redirect:/listPurchase.do";
		
	}
	
	
	
}
