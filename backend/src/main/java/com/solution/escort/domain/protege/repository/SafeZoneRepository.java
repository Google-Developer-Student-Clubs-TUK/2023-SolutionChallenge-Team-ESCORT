package com.solution.escort.domain.protege.repository;

import com.solution.escort.domain.protege.entity.SafeZone;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SafeZoneRepository extends JpaRepository<SafeZone, Integer> {
    @Query(value = "select safe_address from safe_zone where protege_id = ?1",nativeQuery = true)
    List<String> findSafeZonesByProtegeId(Integer id);

}
