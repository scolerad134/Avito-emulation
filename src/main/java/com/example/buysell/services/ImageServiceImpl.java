package com.example.buysell.services;


import com.example.buysell.models.Image;
import com.example.buysell.repositories.ImageRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class ImageServiceImpl implements ImageService {

    private final ImageRepository imageRepository;

    @Override
    public Image findById(Long id) {
        return imageRepository.findById(id).orElse(null);
    }
}
