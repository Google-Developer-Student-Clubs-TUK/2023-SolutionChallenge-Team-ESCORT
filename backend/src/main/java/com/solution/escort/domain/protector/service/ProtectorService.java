package com.solution.escort.domain.protector.service;

import com.solution.escort.domain.protector.dto.request.ProtectorRequestDTO;
import com.solution.escort.domain.protector.dto.response.ProtectorResponseDTO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface ProtectorService {
    public void createProtector(ProtectorRequestDTO protectorRequestDTO, String url) throws Exception;

    public ProtectorResponseDTO getProtectorById(Integer id) throws Exception;
}
