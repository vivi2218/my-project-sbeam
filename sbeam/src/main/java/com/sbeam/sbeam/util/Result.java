package com.sbeam.sbeam.util;

public class Result {
    private int code;
    private String message;
    private Object data;

    public Result(){}
    public Result(int code, String message, Object data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }


    public static Result registSuccess(Object data){
        return new Result(200,"注册成功",data);
    }
    public static Result registFail(Object data){
        return new Result(201,"注册失败",data);
    }
    // 登录
    public static Result loginSuccess(Object data){
        return new Result(200,"登录成功",data);
    }
    public static Result loginFail(Object data){
        return new Result(201,"登录失败",data);
    }



    //退出
    public static Result logoutSuccess(Object data){
        return new Result(200,"退出成功",data);
    }
    public static Result logoutFail(Object data){
        return new Result(201,"退出失败",data);
    }


    // 查询
    public static Result getSuccess(Object data){
        return new Result(200,"查询成功",data);
    }
    public static Result getFail(Object data){
        return new Result(201,"查询失败",data);
    }

    // 添加
    public static Result saveSuccess(Object data){
        return new Result(200,"添加成功",data);
    }
    public static Result saveFail(Object data){
        return new Result(201,"添加失败",data);
    }
    // 修改
    public static Result updateSuccess(Object data){
        return new Result(200,"修改成功",data);
    }
    public static Result updateFail(Object data){
        return new Result(201,"修改失败",data);
    }
    // 删除
    public static Result deleteSuccess(Object data){
        return new Result(200,"删除成功",data);
    }
    public static Result deleteFail(Object data){
        return new Result(201,"删除失败",data);
    }






    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "Result{" +
                "code=" + code +
                ", message='" + message + '\'' +
                ", data=" + data +
                '}';
    }
}
