package pulu.com.common;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component("fileUtils")
public class FileUtils {

	private static final String filePath = "C:\\Java\\stsApp\\puluDev_final\\src\\main\\webapp\\resources\\file\\";
    
	//파일 등록
	public List<Map<String, Object>> parseInsertFileInfo(Map<String, Object> map, HttpServletRequest request)
			throws Exception {
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

		MultipartFile multipartFile = null;
		String IMAGE_IMG = null;
		String originalFileExtension = null;
		String IMAGE_STORED = null;
		int i = 1;

		List<Map<String, Object>> list = new ArrayList<>();

		Map<String, Object> listMap = null;
		String IMAGE_GOODS_NUM = (String) map.get("GOODS_NUM");

		File file = new File(filePath);
        
		//파일이 없을경우 파일생성
		if (!file.exists()) {
			file.mkdirs();
		}

		while (iterator.hasNext()) {
			multipartFile = multipartHttpServletRequest.getFile(iterator.next());
			if (!multipartFile.isEmpty()) {

				IMAGE_IMG = multipartFile.getOriginalFilename();
				originalFileExtension = IMAGE_IMG.substring(IMAGE_IMG.lastIndexOf("."));
				IMAGE_STORED = CommonUtils.getRandomString() + originalFileExtension;

				file = new File(filePath + IMAGE_STORED);
				multipartFile.transferTo(file);

				listMap = new HashMap<>();
				listMap.put("IMAGE_GOODS_NUM", IMAGE_GOODS_NUM);
				listMap.put("IMAGE_IMG", IMAGE_IMG);
				listMap.put("IMAGE_STORED", IMAGE_STORED);
				listMap.put("IMAGE_SIZE", multipartFile.getSize());
				listMap.put("IMAGE_CATEGORY", Integer.toString(i++));
				list.add(listMap);
			}
		}
		return list;
	}
    
	//파일수정
	public List<Map<String, Object>> parseUpdateFileInfo(Map<String, Object> map, HttpServletRequest request) throws Exception{
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

		MultipartFile multipartFile = null;
		String IMAGE_IMG = null;
		String originalFileExtension = null;
		String IMAGE_STORED = null;

		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> listMap = null;

		String IMAGE_GOODS_NUM = (String) map.get("GOODS_NUM");
		String requestName = null;
		String idx = null;
		int i = 2;
		
		/* int IMAGE_CATEGORY = (int) map.get("IMAGE_CATEGORY"); */
		/* String IMAGE_CATEGORY = String.valueOf(map.get("IMAGE_CATEGORY_idx")); */
		 

		while (iterator.hasNext()) {
			multipartFile = multipartHttpServletRequest.getFile(iterator.next());
			
			//파일이 존재하면
			if (!multipartFile.isEmpty() ) {
				IMAGE_IMG = multipartFile.getOriginalFilename();
				originalFileExtension = IMAGE_IMG.substring(IMAGE_IMG.lastIndexOf("."));
				IMAGE_STORED = CommonUtils.getRandomString() + originalFileExtension;
			
				String IMAGE_CATEGORY = (String) map.get("IMAGE_CATEGORY_0"); 
				
				multipartFile.transferTo(new File(filePath + IMAGE_STORED));

				listMap = new HashMap<String, Object>();
				listMap.put("IS_NEW", "Y");
				listMap.put("IMAGE_GOODS_NUM", IMAGE_GOODS_NUM);
				listMap.put("IMAGE_IMG", IMAGE_IMG);
				listMap.put("IMAGE_STORED", IMAGE_STORED);
			  
				listMap.put("IMAGE_SIZE", multipartFile.getSize());
				listMap.put("IMAGE_CATEGORY", IMAGE_CATEGORY); 			    
				list.add(listMap);
				
			
				System.out.println("idx 수정전========"+ idx);
				System.out.println("list변경전===========" + list);
				
			
		
			} else {
				requestName = multipartFile.getName();
				idx = "IDX_" + requestName.substring(requestName.indexOf("_") + 1);
				  
				//map에 idx값이 존재하고 map에서 idx를 받아오면
				if (map.containsKey(idx) == true && map.get(idx) != null) {
					
					System.out.println("idx변경전===========" + idx);
					
					listMap = new HashMap<String, Object>();
					listMap.put("IS_NEW", "N");
					listMap.put("FILE_IDX", map.get(idx));
				    listMap.put("IMAGE_CATEGORY", Integer.toString(i++)); 
					
					
				
					list.add(listMap);
				
					System.out.println("idx 수정후========"+ idx);
					
				
					System.out.println("list변경후===========" + list);
				}
			}
		}
		return list;
	}
}