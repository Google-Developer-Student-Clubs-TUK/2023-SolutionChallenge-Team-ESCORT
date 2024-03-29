package com.solution.escort.domain.PPConnection.service;

import com.solution.escort.domain.PPConnection.dto.request.PPConnectionRequestDTO;
import com.solution.escort.domain.PPConnection.dto.response.PgeResponseDTO;
import com.solution.escort.domain.PPConnection.dto.response.PtorResponseDTO;
import com.solution.escort.domain.PPConnection.entity.ProtectorProtege;
import com.solution.escort.domain.PPConnection.repository.PPconnectionRepository;
import com.solution.escort.domain.protector.entity.Protector;
import com.solution.escort.domain.protector.repository.ProtectorRepository;
import com.solution.escort.domain.protege.entity.Protege;
import com.solution.escort.domain.protege.repository.ProtegeRepository;
import com.solution.escort.domain.protege.repository.SafeZoneRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class
PPConnectionServiceImpl implements PPConnectionService{

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
    public void ppConnection(Protege protege, Protector protector) throws Exception {

        if (protege== null) {
            throw new Exception("유효하지 않은 노인 아이디 정보 입니다.");
        }
        if (protector == null){
            throw new Exception("유효하지 않은 보호자 아이디 정보입니다.");
        }
        ProtectorProtege protectorProtege = new ProtectorProtege();
        protectorProtege.setProtege(protege);
        protectorProtege.setProtector(protector);

        ppConnectionRepository.save(protectorProtege);
    }

    // 보호자 -> 등록된 노인 리스트와 가져오는 API
    public List<PgeResponseDTO> getProtegeByProtectorId(Integer protectorId) throws Exception {
        Protege proteges = new Protege();
        List<Integer> strProteges = ppConnectionRepository.findProtegeIdByOrderByProtectorIdDesc(protectorId);
        List<PgeResponseDTO> protegesAll = new ArrayList<>();
        for (Integer protegeEle: strProteges) {
            proteges = protegeRepository.findById(protegeEle).get();
            List<String> safeZones = new ArrayList<>();
            List<String> strSafeZones = safeZoneRepository.findSafeZonesByProtegeId(protegeEle);
            safeZones.addAll(strSafeZones);

            protegesAll.add(proteges.toPgResponseDTO(proteges,safeZones));
        }

        return protegesAll;

    }

    // 노인 -> 등록한 보호자 리스트 가져오는 API
    public List<PtorResponseDTO> getProtectorByProtegeId(Integer protegeId) throws Exception {
        Protector protectors = new Protector();

        List<Integer> strProtectors = ppConnectionRepository.findProtectorIdByOrderByProtegeIdDesc(protegeId);
        List<PtorResponseDTO> protectorsAll = new ArrayList<>();

        for(Integer protectorEle: strProtectors) {
            protectors = protectorRepository.findById(protectorEle).get();

            protectorsAll.add(protectors.toPtorResponseDTO(protectors));
        }
        return protectorsAll;
    }


}
