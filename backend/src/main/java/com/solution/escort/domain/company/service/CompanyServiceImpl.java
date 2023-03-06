package com.solution.escort.domain.company.service;

import com.solution.escort.domain.company.dto.request.CompanyRequestDTO;
import com.solution.escort.domain.company.dto.response.CompanyResponseDTO;
import com.solution.escort.domain.company.entity.Company;
import com.solution.escort.domain.company.repository.CompanyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CompanyServiceImpl implements CompanyService{

    @Autowired
    private CompanyRepository companyRepository;

    @Override
    public void createCompany(CompanyRequestDTO companyRequestDTO) throws Exception {
        Company saveCompany = companyRequestDTO.toCompanyEntity(companyRequestDTO);
        companyRepository.save(saveCompany);
    }

    @Override
    public CompanyResponseDTO getCompanyById(Integer id) throws Exception {
        Company company = companyRepository.findById(id).get();
        return company.toCompanyResponseDTO(company);
    }

    @Override
    public List<CompanyResponseDTO> getCompanyAll() throws Exception {
        List<Company> companyAll = companyRepository.findAll();
        return toCompanyResponse(companyAll);
    }

    public List<CompanyResponseDTO> toCompanyResponse(List<Company> companyAll) throws Exception {
        List<CompanyResponseDTO> companyResponseDTOList = new ArrayList<>();
        for(Company company : companyAll) {
            companyResponseDTOList.add(company.toCompanyResponseDTO(company));
        }
        return companyResponseDTOList;
    }
}
