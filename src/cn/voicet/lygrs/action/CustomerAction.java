package cn.voicet.lygrs.action;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.voicet.common.action.BaseAction;
import cn.voicet.common.util.DotSession;
import cn.voicet.lygrs.dao.CustomerDao;
import cn.voicet.lygrs.form.CustomerForm;

import com.opensymphony.xwork2.ModelDriven;

@Controller("customerAction")
@Scope(value="prototype")
@SuppressWarnings("serial")
public class CustomerAction extends BaseAction implements ModelDriven<CustomerForm>{
	private static Logger log = Logger.getLogger(CustomerAction.class);
	@Resource(name=CustomerDao.SERVICE_NAME)
	private CustomerDao customerDao;
	private CustomerForm customerForm = new CustomerForm();
	
	/*
	 * 话务员列表List
	 */
	private List<Map<String, Object>> alist;
	
	public CustomerForm getModel() {
		return customerForm;
	}
	
	/**
	 * 客户资料导入及分配
	 * @return
	 */
	public String importData()
	{
		List<Map<String, Object>> list = customerDao.queryPiNo();
		request.setAttribute("pList", list);
		return "customerImportPage";
	}
	
	/**
	 * 保存批次号
	 * @return
	 * @throws IOException 
	 */
	public String savePiNo() throws IOException
	{
		log.info("pino:"+customerForm.getPino()+", noteinfo:"+customerForm.getNoteinfo());
		customerDao.savePiNo(customerForm);
		response.getWriter().print("ok");
		return null;
	}
	
	/**
	 * 导入资料
	 * @return
	 */
	public String importTelnum()
	{
		log.info("pino:"+customerForm.getPino()+", uploadExcel file:"+uploadExcel);
		customerDao.batchImportData(uploadExcel, customerForm.getPino());
		log.info("import complete");
		return null;
	}
	
	/**
	 * 分配话务员
	 * @return
	 */
	public String alloc()
	{
		List<Map<String, Object>> list = customerDao.queryAgentList();
		request.setAttribute("aList", list);
		return "allocAgentPage";
	}
	
	public String allocAgent()
	{
		log.info("pino:"+customerForm.getPino()+", allocnum:"+customerForm.getAllocnum()+", agentlist:"+customerForm.getAgentlist());
		customerDao.allocAgentByPino(customerForm);
		return null;
	}
	
	public String clearPino()
	{
		customerDao.clearPino(customerForm);
		log.info("清空批次["+customerForm.getPino()+"]完成");
		return null;
	}
	
	public String resetFenpei()
	{
		customerDao.resetFenpei(customerForm);
		log.info("重置分配批次["+customerForm.getPino()+"]完成");
		return null;
	}
	
	public String deletePici()
	{
		customerDao.deletePici(customerForm);
		log.info("删除批次["+customerForm.getPino()+"]完成");
		return null;
	}
	
	
	/*************************************************************************************************/
	/************************************** 客户资料管理页面  ******************************************/
	/*************************************************************************************************/
	/**
	 * 查询客户资料列表
	 * @return
	 */
	public String query()
	{
		DotSession ds = DotSession.getVTSession(request);
		customerForm.setQ_agtacc(ds.agttelnum);
		String findAll = request.getParameter("f");
		if(null!=findAll && findAll.equals("all"))
		{
			customerForm.setQ_agtacc(null);
		}
		log.info("q_pino:"+customerForm.getQ_pino()+", q_caryear:"+customerForm.getQ_caryear()+", q_chuxcs:"+customerForm.getQ_chuxcs()+", q_chephm:"+customerForm.getQ_chephm()+", q_uname:"+customerForm.getQ_uname()+", q_mobile:"+customerForm.getQ_mobile()+", q_agtacc:"+customerForm.getQ_agtacc());
		List<Map<String, Object>> list = customerDao.queryCustomerInfo(customerForm);
		request.setAttribute("cList", list);
		//
		alist = customerDao.queryAgentList();
		log.info("dfagt:"+ds.dfagt);
		return "customerManagePage";
	}
	
	/**
	 * 导出客户资料列表
	 * @return
	 */
	public String exportAll()
	{
		log.info("pino:"+customerForm.getPino()+", caryear:"+customerForm.getCaryear()+", chuxcs:"+customerForm.getChuxcs()+", chephm:"+customerForm.getChephm()+", uname:"+customerForm.getUname()+", mobile:"+customerForm.getMobile()+", agtacc:"+customerForm.getAgtacc());
		customerDao.exportCustomerData(customerForm, response);
		return null;
	}
	
	public String setDefaultAgent()
	{
		log.info("defaultAgent:"+customerForm.getDefaultAgent());
		DotSession ds = DotSession.getVTSession(request);
		ds.dfagt = customerForm.getDefaultAgent();
		return null;
	}
	
	/**
	 * 删除一条客户资料记录
	 * @return
	 */
	public String deleteCustomerInfo()
	{
		log.info("cid:"+customerForm.getCid());
		customerDao.deleteCustomerInfo(customerForm);
		log.info("delete complete!");
		return null;
	}
	
	/**
	 * 分配客户资料给话务员
	 * @return
	 */
	public String setAgtAlloc()
	{
		DotSession ds = DotSession.getVTSession(request);
		customerForm.setAgtacc(ds.dfagt);
		log.info("cid:"+customerForm.getCid()+", agtacc:"+customerForm.getAgtacc());
		customerDao.allocOneAgent(customerForm);
		return null;
	}
	
	/**
	 * 查询客户资料详情
	 * @return
	 */
	public String viewDetail()
	{
		log.info("cid:"+customerForm.getCid());
		DotSession ds = DotSession.getVTSession(request);
		customerDao.queryDetailInfo(ds, customerForm);
		request.setAttribute("tpMap", ds.map);
		request.setAttribute("callRecordList", ds.list);
		log.info("tpMap:"+ds.map+", list:"+ds.list);
		ds.list=null;
		return "customerDetailPage";
	}
	
	/**
	 * 保存客户资料
	 * @return
	 */
	public String saveCustomerInfo()
	{
		log.info("ids,cid,byear,ot,cp,pp,cfid,eid,odt,edt,uname,crid,mobile,home,office,addr,noteinfo");
		log.info(customerForm.getPino()+","+customerForm.getCid()+","+customerForm.getChuxcs()+","+customerForm.getChephm()+","+customerForm.getChangphm()+","+customerForm.getChejh()+","+customerForm.getFadjbh()+","+customerForm.getChudrq()+","+customerForm.getBaoxdq()+","+customerForm.getUname()+","+customerForm.getIdcard()+","+customerForm.getMobile()+","+customerForm.getHometel()+","+customerForm.getOfficetel()+","+customerForm.getAddress()+","+customerForm.getNoteinfo());
		customerDao.saveCustomerInfo(customerForm);
		rebtnflag = rebtnflag + 1;
		log.info("rebtnflag:"+rebtnflag);
		log.info("save customer info complte!");
		return null;
	}
	
	/**
	 * 设置预约日期时间
	 * @return
	 */
	public String setYuydt()
	{
		log.info("cid:"+customerForm.getCid()+", yuydate:"+customerForm.getYuydate()+", yuytime:"+customerForm.getYuytime());
		customerDao.setYuyueDateTime(customerForm);
		log.info("set yuyue date time complte!");
		return null;
	}
	
	/**
	 * 设置隐藏标记
	 * @return
	 */
	public String setHideFlag()
	{
		log.info("cid:"+customerForm.getCid()+", hideflag:"+customerForm.getHideflag());
		customerDao.setHideFlag(customerForm);
		log.info("set hide flag complte!");
		return null;
	}
	
	public String tanpin()
	{
		/*
		 * 来电弹屏，根据主叫号码【mobile,hometel,officetel】查询客户资料
		 * 当有多条记录时，只提取第一条记录【peeknum=1】
		 */
		log.info("ani:"+customerForm.getAni());
		DotSession ds = DotSession.getVTSession(request);
		customerDao.queryTanpinInfo(ds, customerForm);
		
		//
		request.setAttribute("tpMap", ds.map);
		request.setAttribute("callRecordList", ds.list);
		
		//clear
		ds.list=null;
		ds.map=null;
		//
		return "tanpinPage";
	}
	
	/**
	 * 通话小结
	 * @throws IOException 
	 */
	public String saveTalk() throws IOException
	{
		log.info("cid:"+customerForm.getCid()+", talkdt:"+customerForm.getTalkdt()+", talkresult:"+customerForm.getTalkresult()+", content:"+customerForm.getNoteinfo());
		customerDao.saveTalkContent(customerForm);
		JSONObject json = new JSONObject();
		json.put("cid", customerForm.getCid());
		json.put("tr", customerForm.getTalkresult());
		json.put("ct", customerForm.getNoteinfo());
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().print(json);
		return null;
	}
	
	
	// 下载网络文件
	public void downloadNet() throws MalformedURLException {
		DotSession ds = DotSession.getVTSession(request);
		String wav = request.getParameter("wavFile");
		log.info("wav:"+wav);
		String ip= ds.getIpWithCTS(ds.curCTS);
		log.info("ip");
		URL url = new URL(ip+"/"+wav);
		log.info("url:"+url);
		String filename = wav.substring(wav.indexOf("talk")+5, wav.length());
		log.info("filename:"+filename);
		try {
			URLConnection conn = url.openConnection();
			InputStream inStream = conn.getInputStream();
			// 设置输出的格式
			response.reset();
			response.setContentType("bin");
			response.addHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
			// 循环取出流中的数据
			byte[] b = new byte[1024];
			int len;
			while ((len = inStream.read(b)) > 0)
			response.getOutputStream().write(b, 0, len);
			inStream.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//myFile属性用来封装上传的文件  
    private File uploadExcel;  
    //myFileContentType属性用来封装上传文件的类型  
    private String uploadExcelContentType;  
    //myFileFileName属性用来封装上传文件的文件名  
    private String uploadExcelFileName;
    //控制文件类型
	@SuppressWarnings("unused")
	private static String[] allowFileType = { "xls", "XLS", "xlsx", "XLSX" };

	public File getUploadExcel() {
		return uploadExcel;
	}
	public void setUploadExcel(File uploadExcel) {
		this.uploadExcel = uploadExcel;
	}
	public String getUploadExcelContentType() {
		return uploadExcelContentType;
	}
	public void setUploadExcelContentType(String uploadExcelContentType) {
		this.uploadExcelContentType = uploadExcelContentType;
	}
	public String getUploadExcelFileName() {
		return uploadExcelFileName;
	}
	public void setUploadExcelFileName(String uploadExcelFileName) {
		this.uploadExcelFileName = uploadExcelFileName;
	}
	//
	private int rebtnflag=1;
	public int getRebtnflag() {
		return rebtnflag;
	}
	public void setRebtnflag(int rebtnflag) {
		this.rebtnflag = rebtnflag;
	}

	public List<Map<String, Object>> getAlist() {
		return alist;
	}
	public void setAlist(List<Map<String, Object>> alist) {
		this.alist = alist;
	}
	
}
