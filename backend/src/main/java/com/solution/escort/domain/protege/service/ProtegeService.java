package com.solution.escort.domain.protege.service;

import com.solution.escort.domain.protege.dto.request.ProtegeRequestDTO;
import com.solution.escort.domain.protege.dto.response.ProtegeResponseDTO;

import java.util.List;

public interface ProtegeService {
    // 노인 회원가입 관련 서비스
    public void createProtege(ProtegeRequestDTO protegeRequestDTO, List<String> safeZoneAddress) throws Exception;

    // 노인 한명의 정보 가져오기 관련 서비스
    public ProtegeResponseDTO getProtegeById(Integer id) throws Exception;

}
