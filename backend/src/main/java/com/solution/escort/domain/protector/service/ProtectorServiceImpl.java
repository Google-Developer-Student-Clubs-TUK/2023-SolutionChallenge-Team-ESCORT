package com.solution.escort.domain.protector.service;

import com.solution.escort.domain.protector.dto.request.ProtectorRequestDTO;
import com.solution.escort.domain.protector.entity.Protector;
import com.solution.escort.domain.protector.repository.ProtectorRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityExistsException;

@Service
@Slf4j
public class ProtectorServiceImpl implements ProtectorService {

    @Autowired
    private ProtectorRepository protectorRepository;

    // 보호자 회원가입 API 관련 서비스
    @Override
    public void createProtector(ProtectorRequestDTO protectorRequestDTO) throws Exception {
        if (protectorRepository.existsByEmail(protectorRequestDTO.getEmail())){
            throw new EntityExistsException();
        }
        Protector saveProtector = protectorRequestDTO.toProtectorEntity(protectorRequestDTO);
        protectorRepository.save(saveProtector);

    }
}
