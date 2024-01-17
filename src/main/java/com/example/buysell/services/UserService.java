package com.example.buysell.services;

import com.example.buysell.models.User;

import java.util.List;

public interface UserService {
    public User findByEmail(String email);
    public boolean createUser(User user);
    public User findById(Long id);
    public List<User> findAll();
    public void banUser(Long id);
}
