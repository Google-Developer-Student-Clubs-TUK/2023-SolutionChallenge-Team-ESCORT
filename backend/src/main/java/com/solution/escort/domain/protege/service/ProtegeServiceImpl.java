package com.solution.escort.domain.protege.service;

import com.solution.escort.domain.protege.dto.request.ProtegeClothRequestDTO;
import com.solution.escort.domain.protege.dto.request.ProtegeRequestDTO;
import com.solution.escort.domain.protege.dto.response.ProtegeResponseDTO;
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
import java.util.Optional;

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
    public void createProtege(ProtegeRequestDTO protegeRequestDTO, List<String> safeZoneAddress, String url) throws Exception {
        if(protegeRepository.existsByEmail(protegeRequestDTO.getEmail())){
            throw new EntityExistsException();
        }
        Protege saveProtege = protegeRequestDTO.toProtegeEntity(protegeRequestDTO);
        protegeRepository.save(saveProtege);

        saveProtege.setImageUrl(url);

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

    // 노인 한명 정보 가져오기 관련 서비스
    @Override
    public ProtegeResponseDTO getProtegeById(Integer id) throws Exception {
        Protege protege = protegeRepository.findById(id).get();
        List<String> safeZones = new ArrayList<>();
        List<String> strSafeZones = safeZoneRepository.findSafeZonesByProtegeId(protege.getId());
        //String safeZone = new String(strSafeZone);
        safeZones.addAll(strSafeZones);
        return protege.toProtegeResponseDTO(protege, safeZones);
    }

    // 노인 신고 시 노인의 옷차림 추가하는 API 관련 서비스
    @Override
    public void protegeCloth(ProtegeClothRequestDTO protegeClothRequestDTO, Integer id) throws Exception {
        Optional<Protege> updateProtege = protegeRepository.findById(id);

        updateProtege.ifPresent(selectProtege -> {
            selectProtege.setClothing(protegeClothRequestDTO.getClothing());

            protegeRepository.save(selectProtege);
        });
    }

}
