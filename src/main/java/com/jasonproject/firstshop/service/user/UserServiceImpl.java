package com.jasonproject.firstshop.service.user;

import com.jasonproject.firstshop.persistence.user.UserRepository;
import com.jasonproject.firstshop.service.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserServiceImpl(UserRepository userRepository) {
        System.out.println(this.getClass());
        this.userRepository = userRepository;
    }

    @Override
    public void addUser(User user) throws Exception {

    }

    @Override
    public User getUser(String userId) throws Exception {
        return userRepository.findByUserId(userId);
    }

    @Override
    public void updateUser(User user) throws Exception {

    }

    @Override
    public boolean checkDuplication(String userId) throws Exception {
        return false;
    }
}
