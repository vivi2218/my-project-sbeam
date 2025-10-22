package com.sbeam.sbeam.minio;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/minio")
public class MinIOController {
    @Autowired
    private MinioService minioService;
    @PostMapping("/upload")
    public ResponseEntity<String> uploadFile(@RequestParam("file") MultipartFile file) {
        try {
            String objectName = minioService.uploadFile(file);
            return ResponseEntity.ok("文件上传成功，对象名称: " + objectName);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("文件上传失败: " + e.getMessage());
        }
    }
    @GetMapping("getUrl")
    public ResponseEntity<String> getFileUrl(@RequestParam String objectName) {
        try {
            String url = minioService.getFileUrl(objectName, 360);
            return ResponseEntity.ok(url);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("获取文件URL失败: " + e.getMessage());
        }
    }
    // 删除文件
    @GetMapping("/delete")
    public ResponseEntity<String> deleteFile(@RequestParam String objectName) {
        try {
            minioService.deleteFile(objectName);
            return ResponseEntity.ok("文件删除成功");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("文件删除失败: " + e.getMessage());
        }
    }



    //返回文件名字并且返回URL,,,你上传文件之后会直接返回URL与文件名字
    @PostMapping("/uploadgeturl")
    public ResponseEntity<Map<String, String>> uploadFileGetURL(@RequestParam("file") MultipartFile file) {
        try {
            String objectName = minioService.uploadFile(file);
            String url = minioService.getFileUrl(objectName, 60);
            Map<String, String> result = new HashMap<>();
            result.put("objectName", objectName);
            result.put("url", url);
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("error", e.getMessage()));
        }
    }

}