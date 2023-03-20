package com.solution.escort.domain.company.controller;

import com.solution.escort.domain.company.dto.request.CompanyRequestDTO;
import com.solution.escort.domain.company.dto.response.CompanyResponseDTO;
import com.solution.escort.domain.company.service.CompanyService;
import com.solution.escort.global.GCP.GCPService;
import com.solution.escort.global.ResponseFormat;
import com.solution.escort.global.ResponseStatus;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@Slf4j
@RequestMapping("api/v1/company")
public class CompanyController {
    @Autowired
    private CompanyService companyService;

    @Autowired
    private GCPService gcpService;

    // 동행기업 등록 API
    @PostMapping
    public ResponseEntity<ResponseFormat<CompanyResponseDTO>> createCompany(CompanyRequestDTO dto, @RequestPart("images") List<MultipartFile> multipartFiles) throws Exception {
        if (multipartFiles == null) {
            log.warn("파일없음");
        }
        List<String> urls = gcpService.uploadFileList(multipartFiles);
        companyService.createCompany(dto, urls);
        ResponseFormat<CompanyResponseDTO> responseFormat = new ResponseFormat<>(ResponseStatus.POST_COMPANY_SUCCESS);
        return ResponseEntity.status(HttpStatus.CREATED).body(responseFormat);
    }

    // id별 동행기업 가져오는 API
    @GetMapping("/{id}")
    public ResponseEntity<ResponseFormat<CompanyResponseDTO>> getCompanyById(@PathVariable Integer id) throws Exception {
        CompanyResponseDTO company = companyService.getCompanyById(id);
        ResponseFormat<CompanyResponseDTO> responseFormat = new ResponseFormat<>(ResponseStatus.GET_COMPANY_BY_ID_SUCCESS, company);
        return ResponseEntity.status(HttpStatus.OK).body(responseFormat);
    }

    // 전체 동행기업 가져오는 API
    @GetMapping
    public ResponseEntity<ResponseFormat<List<CompanyResponseDTO>>> getCompanyAll() throws Exception {
        List<CompanyResponseDTO> companyAll = null;
        companyAll = companyService.getCompanyAll();
        ResponseFormat<List<CompanyResponseDTO>> responseFormat = new ResponseFormat<>(ResponseStatus.GET_COMPANY_SUCCESS, companyAll);
        return ResponseEntity.status(HttpStatus.OK).body(responseFormat);
    }


}
