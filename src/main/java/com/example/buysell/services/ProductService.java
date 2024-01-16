package com.example.buysell.services;

import com.example.buysell.models.Product;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface ProductService {
    public List<Product> listProducts(String title);
    public void saveProduct(Product product, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException;
    public void deleteProduct(Long id);
    public Product getProductById(Long id);
}
