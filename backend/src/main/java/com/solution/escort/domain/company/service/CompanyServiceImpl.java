package com.solution.escort.domain.company.service;

import com.solution.escort.domain.company.dto.request.CompanyRequestDTO;
import com.solution.escort.domain.company.dto.response.CompanyResponseDTO;
import com.solution.escort.domain.company.entity.Company;
import com.solution.escort.domain.company.entity.CompanyImage;
import com.solution.escort.domain.company.repository.CompanyImageRepository;
import com.solution.escort.domain.company.repository.CompanyRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class CompanyServiceImpl implements CompanyService{

    @Autowired
    private CompanyRepository companyRepository;

    @Autowired
    private CompanyImageRepository companyImageRepository;

    @Override
    public void createCompany(CompanyRequestDTO companyRequestDTO, List<String> urls) throws Exception {
        Company saveCompany = companyRequestDTO.toCompanyEntity(companyRequestDTO);
        companyRepository.save(saveCompany);
        List<String> urlList = new ArrayList<>();
        for(String fileUrl: urls) {
            CompanyImage image = CompanyImage.builder()
                    .imageUrl(fileUrl)
                    .company(saveCompany)
                    .build();
            companyImageRepository.save(image);
            urlList.add(image.getImageUrl());
        }
    }

    @Override
    public CompanyResponseDTO getCompanyById(Integer id) throws Exception {
        Company company = companyRepository.findById(id).get();

        List<URL> images = new ArrayList<>();
        List<String> strUrls = companyImageRepository.findImagesByCompanyId(company.getId());
        for(String Urls: strUrls) {
            URL url = new URL(Urls);
            images.add(url);
        }
        return company.toCompanyListResponseDTO(company, images);
    }

    @Override
    public List<CompanyResponseDTO> getCompanyAll() throws Exception {
        List<Company> companyAll = companyRepository.findAll();
        List<URL> images = new ArrayList<>();
        

        return toCompanyResponse(companyAll);
    }

    public List<CompanyResponseDTO> toCompanyResponse(List<Company> companyAll) throws Exception {
        List<CompanyResponseDTO> companyResponseDTOList = new ArrayList<>();
        for(Company company : companyAll) {
            List<URL> images = new ArrayList<>();
            List<String> strUrls = companyImageRepository.findImagesByCompanyId(company.getId());
            for(String Urls: strUrls) {
                URL url = new URL(Urls);
                images.add(url);
            }
            companyResponseDTOList.add(company.toCompanyResponseDTO(company, images));
        }

        return companyResponseDTOList;
    }
}
