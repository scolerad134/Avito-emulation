package com.example.buysell.services;

import com.example.buysell.models.Product;
import com.example.buysell.models.User;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

public interface ProductService {
    public List<Product> listProducts(String title);
    public void saveProduct(Principal principal, Product product, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException;
    public void deleteProduct(Long id);
    public Product getProductById(Long id);
    public User getUserByPrincipal(Principal principal);
}
