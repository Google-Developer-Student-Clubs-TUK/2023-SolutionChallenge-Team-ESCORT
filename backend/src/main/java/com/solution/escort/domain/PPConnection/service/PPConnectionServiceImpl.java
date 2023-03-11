package com.solution.escort.domain.PPConnection.service;

import com.solution.escort.domain.PPConnection.dto.request.PPConnectionRequestDTO;
import com.solution.escort.domain.PPConnection.dto.response.PgeResponseDTO;
import com.solution.escort.domain.PPConnection.entity.ProtectorProtege;
import com.solution.escort.domain.PPConnection.repository.PPconnectionRepository;
import com.solution.escort.domain.protector.repository.ProtectorRepository;
import com.solution.escort.domain.protege.dto.response.ProtegeResponseDTO;
import com.solution.escort.domain.protege.entity.Protege;
import com.solution.escort.domain.protege.entity.SafeZone;
import com.solution.escort.domain.protege.repository.ProtegeRepository;
import com.solution.escort.domain.protege.repository.SafeZoneRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class PPConnectionServiceImpl implements PPConnectionService{

    @Autowired
    private PPconnectionRepository ppConnectionRepository;

    @Autowired
    private ProtegeRepository protegeRepository;

    @Autowired
    private ProtectorRepository protectorRepository;

    @Autowired
    private SafeZoneRepository safeZoneRepository;

    // 보호자 노인 등록 API 관련 서비스
    @Override
    public void ppConnection(PPConnectionRequestDTO ppConnectionRequestDTO) throws Exception {
        log.info(String.valueOf(ppConnectionRequestDTO));

        if (ppConnectionRequestDTO.getProtegeId() == null) {
            throw new Exception("유효하지 않은 노인 아이디 정보 입니다.");
        }
        if (ppConnectionRequestDTO.getProtectorId() == null){
            throw new Exception("유효하지 않은 보호자 아이디 정보입니다.");
        }
        ProtectorProtege savePPConnection = ppConnectionRequestDTO.toPPEntity(ppConnectionRequestDTO);
        ppConnectionRepository.save(savePPConnection);
    }

    // 보호자 -> 등록된 노인 리스트와 가져오는 API
    public List<PgeResponseDTO> getProtegeByProtectorId(Integer protectorId) throws Exception {
        Protege proteges = new Protege();
        List<Integer> strProteges = ppConnectionRepository.findProtegeIdByOrderByProtectorIdDesc(protectorId);
        List<PgeResponseDTO> protesAll = new ArrayList<>();
        for (Integer protegeEle: strProteges) {
            proteges = protegeRepository.findById(protegeEle).get();
            List<String> safeZones = new ArrayList<>();
            List<String> strSafeZones = safeZoneRepository.findSafeZonesByProtegeId(protegeEle);
            safeZones.addAll(strSafeZones);

            protesAll.add(proteges.toPgResponseDTO(proteges,safeZones));
        }

        return protesAll;

    }


}
