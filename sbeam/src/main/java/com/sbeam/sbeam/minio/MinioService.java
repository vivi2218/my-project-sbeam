package com.sbeam.sbeam.minio;


import com.sbeam.sbeam.config.MinioConfig;
import io.minio.*;
import io.minio.http.Method;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Service
public class MinioService {
    @Autowired
    private MinioConfig minioConfig;
    @Autowired
    private MinioClient minioClient;

    /**
     * 上传文件到MinIO
     * @param file 要上传的文件（Spring MultipartFile）
     * @return 文件在MinIO中的唯一标识（对象名称）
     */
    public String uploadFile(MultipartFile file) throws Exception {
        // 1. 检查存储桶是否存在，不存在则创建
        if (!minioClient.bucketExists(BucketExistsArgs.builder().bucket(minioConfig.getBucket()).build())) {
            minioClient.makeBucket(MakeBucketArgs.builder().bucket(minioConfig.getBucket()).build());
        }

        // 2. 生成唯一文件名（避免重名）
        String originalFilename = file.getOriginalFilename();
        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String objectName = UUID.randomUUID().toString() + fileExtension;
        objectName = objectName.trim(); // 避免空格
        //最终存放位置  桶名/objectName.fileExtension
        //也可以 objectName = "test/"+UUID.randomUUID().toString() + fileExtension;
        //那么最终保存在  桶名/test/UUID.fileExtension


        // 3. 上传文件
        minioClient.putObject(
                PutObjectArgs.builder()
                        .bucket(minioConfig.getBucket())          // 存储桶名称
                        .object(objectName)          // 对象名称（文件名）
                        .stream(file.getInputStream(), file.getSize(), -1)  // 文件流和大小
                        .contentType(file.getContentType())  // 文件类型,是http协议的mime类型,即内容类型
                        .build());



                        //`file.getInputStream()`    读取文件的输入流（Spring 会自动提供） |

        //如果是outputStream()   就是写入文件的输出流
                        // `file.getSize()`         文件的字节大小（方便 MinIO 知道数据长度） |
                        // `-1`                     分片大小（`-1` 表示自动选择，适用于小文件） |


                        //看到这个文件的名字,浏览器就知道这是什么类型的文件了
                        //如果是  .jpg   那么对应的contentType就是image/jpeg
                        //| 文件类型    | contentType 值      |
                        //| ------- | ------------------ |
                        //| `.jpg`  | `image/jpeg`       |
                        //| `.png`  | `image/png`        |
                        //| `.pdf`  | `application/pdf`  |
                        //| `.mp4`  | `video/mp4`        |
                        //| `.json` | `application/json` |
                        //| `.zip`  | `application/zip`  |




        //如果是photo.jpg
        //那么文件名字就是   objectName   a1b2c3d4.jpg
        //minio元数据  Content-Type=image/jpeg
        //fileExtension 决定文件名长什么样，
        //contentType 决定别人看到这个文件时怎么“理解”它。


        return objectName;
        //返回结果：test/随机字符串.txt

    }




        //2.获取文件url
        /*
         * 获取文件临时访问URL（适合前端直接下载）
         * @param objectName 文件在MinIO中的唯一标识
         * @param expiry 有效期（单位：分钟）
         * @return 可访问的URL
         */
        public String getFileUrl(String objectName, int expiry) throws Exception {
            //objectName = "随机字符串.txt"
            return minioClient.getPresignedObjectUrl(
                    GetPresignedObjectUrlArgs.builder()
                            .method(Method.GET)
                            .bucket(minioConfig.getBucket())
                            .object(objectName)
                            .expiry(expiry, TimeUnit.MINUTES)
                            .build());
            //返回结果：http://localhost:9000/bucket/随机字符串.txt?......
        }






        //3.删除文件
        /*
         * 删除文件
         * @param objectName 文件在MinIO中的唯一标识
         */
        public void deleteFile(String objectName) throws Exception {
            //objectName = "随机字符串.txt"
            minioClient.removeObject(
                    RemoveObjectArgs.builder()
                            .bucket(minioConfig.getBucket())
                            .object(objectName)
                            .build());
        }







    }

