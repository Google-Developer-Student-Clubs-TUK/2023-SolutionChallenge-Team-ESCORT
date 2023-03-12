package com.solution.escort.domain.protector.service;

import com.solution.escort.domain.protector.dto.request.ProtectorRequestDTO;
import com.solution.escort.domain.protector.dto.response.ProtectorResponseDTO;
import com.solution.escort.domain.protector.entity.Protector;
import com.solution.escort.domain.protector.repository.ProtectorRepository;
import com.solution.escort.domain.protege.dto.response.ProtegeResponseDTO;
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
    public void createProtector(ProtectorRequestDTO protectorRequestDTO, String url) throws Exception {
        if (protectorRepository.existsByEmail(protectorRequestDTO.getEmail())){
            throw new EntityExistsException();
        }
        Protector saveProtector = protectorRequestDTO.toProtectorEntity(protectorRequestDTO);
        saveProtector.setImageUrl(url);
        protectorRepository.save(saveProtector);


        //saveProtector.setImageUrl(url);

    }

    // 보호자 노인 등록 API 관련 서비스

    // 보호자 한명 정보 가져오는 API
    @Override
    public ProtectorResponseDTO getProtectorById(Integer id) throws Exception {
        Protector protector = protectorRepository.findById(id).get();
        return protector.toProtectorResponseDTO(protector);
    }

}
