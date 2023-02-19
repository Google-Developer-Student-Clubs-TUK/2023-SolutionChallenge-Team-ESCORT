package com.solution.escort.domain.protector.service;

import com.solution.escort.domain.protector.dto.request.ProtectorRequestDTO;

import java.util.List;

public interface ProtectorService {
    public void createProtector(ProtectorRequestDTO protectorRequestDTO) throws Exception;

}
