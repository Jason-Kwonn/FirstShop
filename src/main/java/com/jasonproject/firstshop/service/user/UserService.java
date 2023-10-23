package com.jasonproject.firstshop.service.user;

import com.jasonproject.firstshop.service.domain.User;

import java.util.List;

public interface UserService {
    // 회원가입
    User addUser(User user) throws Exception;

    // 내정보확인 / 로그인
    User getOneUser(String userId) throws Exception;

    // 유저 전체 정보 가져오기
    List<User> getAllUser() throws Exception;

    // 회원정보리스트
//    public Map<String , Object> getUserList(Search search) throws Exception;

    // 회원정보수정
    User updateUser(User user) throws Exception;

    // 회원 ID 중복 확인
    boolean checkDuplication(String userId) throws Exception;
}
