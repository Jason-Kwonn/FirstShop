package com.jasonproject.firstshop.service.user;

import com.jasonproject.firstshop.persistence.user.UserRepository;
import com.jasonproject.firstshop.service.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserServiceImpl(UserRepository userRepository) {
        System.out.println(this.getClass());
        this.userRepository = userRepository;
    }

    @Override
    public User addUser(User user) throws Exception {
        userRepository.save(user);
        System.out.println(userRepository.save(user));
        return user;
    }

    @Override
    public User getOneUser(String userId) throws Exception {
        return userRepository.findByUserId(userId);
    }

    @Override
    public List<User> getAllUser() throws Exception {
        return userRepository.findAll();
    }

    @Override
    public User updateUser(User user) throws Exception {
        userRepository.save(user);
        System.out.println(userRepository.save(user));
        return user;
    }

    @Override
    public boolean checkDuplication(String userId) throws Exception {
        return false;
    }
}
