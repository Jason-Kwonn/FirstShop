package com.jasonproject.firstshop.persistence.user;

import com.jasonproject.firstshop.service.domain.User;
import lombok.NonNull;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, String> {

    @NonNull
    User save(User user);

    User findByUserId(String userId);

    @NonNull
    List<User> findAll();

}
