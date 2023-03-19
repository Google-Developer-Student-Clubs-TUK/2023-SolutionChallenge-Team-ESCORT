package com.solution.escort.domain.protector.service;

import com.solution.escort.domain.protector.dto.request.ProtectorRequestDTO;
import com.solution.escort.domain.protector.dto.request.ProtectorTokenRequestDTO;
import com.solution.escort.domain.protector.dto.response.ProtectorResponseDTO;
import com.solution.escort.domain.protector.entity.Protector;
import com.solution.escort.domain.protector.repository.ProtectorRepository;
import com.solution.escort.domain.protege.dto.response.ProtegeResponseDTO;
import com.solution.escort.domain.protege.repository.ProtegeRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityExistsException;
import javax.swing.text.html.Option;
import java.util.Optional;

@Service
@Slf4j
public class ProtectorServiceImpl implements ProtectorService {

    @Autowired
    private ProtectorRepository protectorRepository;

    @Autowired
    private ProtegeRepository protegeRepository;

    // 보호자 회원가입 API 관련 서비스
    @Override
    public void createProtector(ProtectorRequestDTO protectorRequestDTO, String url) throws Exception {
        if (protectorRepository.existsByEmail(protectorRequestDTO.getEmail()) || protegeRepository.existsByEmail(protectorRequestDTO.getEmail())){
            throw new EntityExistsException();
        }

        if (protectorRepository.existsByFbId(protectorRequestDTO.getUId()) || protegeRepository.existsByFbId(protectorRequestDTO.getUId())){
            throw new EntityExistsException();
        }
        Protector saveProtector = protectorRequestDTO.toProtectorEntity(protectorRequestDTO);
        saveProtector.setImageUrl(url);
        protectorRepository.save(saveProtector);

    }

    // 보호자 한명 정보 가져오는 API
    @Override
    public ProtectorResponseDTO getProtectorById(Integer id) throws Exception {
        Protector protector = protectorRepository.findById(id).get();
        return protector.toProtectorResponseDTO(protector);
    }

    @Override
    public void updateToken(ProtectorTokenRequestDTO protectorTokenRequestDTO, Integer id) throws Exception {
        Optional<Protector> updateProtectorToken = protectorRepository.findById(id);

        updateProtectorToken.ifPresent(selectProtector ->{
            selectProtector.setDeviceToken(protectorTokenRequestDTO.getDeviceToken());
            protectorRepository.save(selectProtector);
        });
    }

}
