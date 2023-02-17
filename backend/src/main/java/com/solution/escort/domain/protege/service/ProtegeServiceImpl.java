package com.solution.escort.domain.protege.service;

import com.solution.escort.domain.protege.dto.request.ProtegeRequestDTO;
import com.solution.escort.domain.protege.entity.Protege;
import com.solution.escort.domain.protege.entity.SafeZone;
import com.solution.escort.domain.protege.repository.ProtegeRepository;
import com.solution.escort.domain.protege.repository.SafeZoneRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityExistsException;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class ProtegeServiceImpl implements ProtegeService {

    @Autowired
    private ProtegeRepository protegeRepository;

    @Autowired
    private SafeZoneRepository safeZoneRepository;

    // 노인 회원가입 API 관련 서비스
    @Override
    public void createProtege(ProtegeRequestDTO protegeRequestDTO, List<String> safeZoneAddress) throws Exception {
        if(protegeRepository.existsByEmail(protegeRequestDTO.getEmail())){
            throw new EntityExistsException();
        }
        Protege saveProtege = protegeRequestDTO.toProtegeEntity(protegeRequestDTO);
        protegeRepository.save(saveProtege);

        List<String> safeZoneList = new ArrayList<>();
        for(String safeZoneadd: safeZoneAddress) {
            SafeZone safeZone = SafeZone.builder()
                    .safeAddress(safeZoneadd)
                    .protege(saveProtege)
                    .build();
            safeZoneRepository.save(safeZone);
            safeZoneList.add(safeZone.getSafeAddress());
    }

    }

    

}
