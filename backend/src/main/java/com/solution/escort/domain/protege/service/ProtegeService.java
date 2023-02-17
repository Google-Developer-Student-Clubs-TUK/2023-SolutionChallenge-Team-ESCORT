package com.solution.escort.domain.protege.service;

import com.solution.escort.domain.protege.dto.request.ProtegeRequestDTO;
import com.solution.escort.domain.protege.entity.SafeZone;

import java.util.List;

public interface ProtegeService {
    // 노인 회원가입 관련 서비스
    public void createProtege(ProtegeRequestDTO protegeRequestDTO, List<String> safeZoneAddress) throws Exception;
}
