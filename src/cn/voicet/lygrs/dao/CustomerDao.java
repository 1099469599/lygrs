package cn.voicet.lygrs.dao;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import cn.voicet.lygrs.form.CustomerForm;

public interface CustomerDao{
	public final static String SERVICE_NAME = "cn.voicet.lygrs.dao.impl.CustomerDaoImpl";
	List<Map<String, Object>> queryPiNo();
	void savePiNo(CustomerForm customerForm);
	void batchImportData(File uploadExcel, String pino);
	List<Map<String, Object>> queryAgentList();
	void allocAgentByPino(CustomerForm customerForm);
	void clearPino(CustomerForm customerForm);
	void resetFenpei(CustomerForm customerForm);
	void deletePici(CustomerForm customerForm);
	//
	List<Map<String, Object>> queryCustomerInfo(CustomerForm customerForm);
	void exportCustomerData(CustomerForm customerForm, HttpServletResponse response);
	void deleteCustomerInfo(CustomerForm customerForm);
	void allocOneAgent(CustomerForm customerForm);
	List<Map<String, Object>> queryCallRecordByCid(CustomerForm customerForm);
	void saveCustomerInfo(CustomerForm customerForm);
	void setYuyueDateTime(CustomerForm customerForm);
	void setHideFlag(CustomerForm customerForm);
	
}
