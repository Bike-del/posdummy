package com.example.posdummy.GlobalException;

public class ResourceNotFoundException extends  RuntimeException{
        public ResourceNotFoundException(String msg){
            super(msg);
        }
}
