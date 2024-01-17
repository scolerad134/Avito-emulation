package com.example.buysell.services;

import com.example.buysell.models.User;

public interface UserService {
    public User findByEmail(String email);
    public boolean createUser(User user);
}
