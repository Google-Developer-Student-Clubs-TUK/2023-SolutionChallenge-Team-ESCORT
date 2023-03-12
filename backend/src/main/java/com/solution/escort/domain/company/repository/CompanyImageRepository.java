package com.solution.escort.domain.company.repository;

import com.solution.escort.domain.company.entity.CompanyImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CompanyImageRepository extends JpaRepository<CompanyImage, Integer> {
    @Query(value = "select image_url from company_image where company_id = ?1",nativeQuery = true)
    List<String> findImagesByCompanyId(Integer id);
}
