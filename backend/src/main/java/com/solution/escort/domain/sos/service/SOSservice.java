package com.solution.escort.domain.sos.service;

import com.solution.escort.domain.sos.dto.request.SOSRequestDTO;

public interface SOSservice {
    public void createSOS(SOSRequestDTO sosRequestDTO) throws Exception;
}
