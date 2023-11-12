package com.jasonproject.firstshop.web.controller.user;

import com.jasonproject.firstshop.service.domain.User;
import com.jasonproject.firstshop.service.user.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/user")
public class UserRestController {

	///Field
	@Qualifier("userServiceImpl")
	private final UserService userService;

	@Autowired
	public UserRestController(UserService userService) {
		System.out.println(this.getClass());
		this.userService = userService;
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public User userLogin(@RequestBody User user) throws Exception {

		System.out.println("/user/login : POST json");

		System.out.println(user);

		User dbUser = userService.getOneUser(user.getUserId());

		System.out.println(dbUser);

		return dbUser;
	}


	@RequestMapping(value = "/checkLogin", method = RequestMethod.GET)
	public User checkLogin(HttpSession session) {

		return (User) session.getAttribute("user");
    }

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public void checkLogout(HttpSession session) {

		session.removeAttribute("user");
	}

	@Transactional
	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
	public User addUser(@RequestBody User user) throws Exception {

		System.out.println("/user/addUser : POST json");
		System.out.println(user);

		//Business Logic
		return userService.addUser(user);
	}

	@Transactional
	@RequestMapping(value = "/updateUser", method = RequestMethod.POST)
	public User updateUser(@RequestBody User user) throws Exception {

		System.out.println("/user/updateUser : POST json");
		System.out.println(user);

		//Business Logic
		return userService.updateUser(user);
	}

	@RequestMapping(value = "/getAllUser", method = RequestMethod.GET)
	public List<User> getUser() throws Exception {

		System.out.println("/user/getAllUser : GET json");

		return userService.getAllUser();
	}

}
