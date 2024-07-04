package com.mediSlot.service;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import com.mediSlot.dao.DoctorScheduleDao;
import com.mediSlot.model.DoctorSchedule;

public class DoctorScheduleService implements IService<DoctorSchedule> {
	private DoctorScheduleDao doctorScheduleDao;

    public DoctorScheduleService(DoctorScheduleDao doctorScheduleDao) {
        this.doctorScheduleDao = doctorScheduleDao;
    }

    @Override
    public DoctorSchedule create(DoctorSchedule doctorSchedule) throws Exception {
        return doctorScheduleDao.create(doctorSchedule);
    }

    @Override
    public boolean update(int id, DoctorSchedule doctorSchedule) throws Exception {
        return doctorScheduleDao.update(id, doctorSchedule);
    }
    
    public boolean updateScheduled(int id, DoctorSchedule doctorSchedule) {
    	return doctorScheduleDao.updateScheduled(id, doctorSchedule);
    }

    @Override
    public boolean delete(int id) throws Exception {
        return doctorScheduleDao.delete(id);
    }

    @Override
    public List<DoctorSchedule> findAll() throws Exception {
        return doctorScheduleDao.findAll();
    }
    
    
    public DoctorSchedule findOneAccToDoctorDateTime(int doctorId, Date availableDate, String availableTime) throws Exception {
        return doctorScheduleDao.findOneAccToDoctorDateTime(doctorId, availableDate, availableTime);
    }

    public List<String> findOneDoctroAccToDate(int doctorID, Date availableDate) throws SQLException {
        return doctorScheduleDao.findOneDoctroAccToDate(doctorID, availableDate);
    }

    public DoctorSchedule findById(int id) {
        return doctorScheduleDao.findById(id);
    }

    public List<String> findAllTime(int doctorId, Date appDate) throws Exception {
        return doctorScheduleDao.findAllTime(doctorId, appDate);
    }
    
    public List<Date> findAllDate(int doctorId) throws Exception {
        return doctorScheduleDao.findAllDate(doctorId);
    }
    
    public List<DoctorSchedule> findAllDoctorSchedulesById(int id) throws SQLException {
    	return doctorScheduleDao.findAllDoctorSchedulesById(id);
    }

}
