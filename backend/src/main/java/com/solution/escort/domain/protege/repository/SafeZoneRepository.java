package com.solution.escort.domain.protege.repository;

import com.solution.escort.domain.protege.entity.SafeZone;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SafeZoneRepository extends JpaRepository<SafeZone, Integer> {

}
