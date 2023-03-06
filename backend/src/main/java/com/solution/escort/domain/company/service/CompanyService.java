package com.solution.escort.domain.company.service;

import com.solution.escort.domain.company.dto.request.CompanyRequestDTO;
import com.solution.escort.domain.company.dto.response.CompanyResponseDTO;
import com.solution.escort.domain.company.entity.Company;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface CompanyService {
    public void createCompany(CompanyRequestDTO companyRequestDTO) throws Exception;

    public CompanyResponseDTO getCompanyById(Integer id) throws Exception;

    public List<CompanyResponseDTO> getCompanyAll() throws Exception;

}
