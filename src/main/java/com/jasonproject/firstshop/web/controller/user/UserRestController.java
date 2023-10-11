package com.jasonproject.firstshop.web.controller.user;

import com.jasonproject.firstshop.service.domain.User;
import com.jasonproject.firstshop.service.user.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.crossstore.ChangeSetPersister;
import org.springframework.web.bind.annotation.*;

import java.util.Objects;

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
	public User userLogin(@RequestBody User user, HttpSession session) throws Exception {

		System.out.println("/user/login : POST json");
		if (user.getUserId() == null) {
			throw new NullPointerException("userId 가 null 입니다.");
		}

		//Business Logic
		User dbUser = userService.getUser(user.getUserId());

		if (user.getPassword().equals(Objects.requireNonNull(dbUser).getPassword())) {
			session.setAttribute("user", dbUser);
		}

		return dbUser;
	}


}
