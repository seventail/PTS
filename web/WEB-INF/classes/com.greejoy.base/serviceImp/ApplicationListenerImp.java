package com.greejoy.base.serviceImp;

import com.greejoy.base.data.StaticResource;
import com.greejoy.car.domain.CameraIp;
import com.greejoy.floor.domain.AkeparkFloorNum;
import com.greejoy.gtip.component.ConfigLoader;
import com.greejoy.gtip.module.rbac.domain.User;
import com.greejoy.user.domain.UserXPerssion;
import com.greejoy.user.domain.UserXStation;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Repository;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Properties;

/**
 * Created by CZJiang on 2016/2/2.
 */
@Repository
public class ApplicationListenerImp implements ApplicationListener {

    public void onApplicationEvent(ApplicationEvent var1){
        User user=User.getByUsername("admin");
        if(user==null){
            user=new User();
            user.setName("bussystem");
            user.setCreateFlag(true);
            user.setForbidFlag(false);
            user.setLevel(1);
            user.setPassword(DigestUtils.shaHex("admin" + "123456"));
            user.setUsername("admin");
            user.setPath("/");
            user.directSave();
        }
        if(StaticResource.akeparkMap.size()==0){
            List<AkeparkFloorNum> list=AkeparkFloorNum.listAll(AkeparkFloorNum.class);
            for(AkeparkFloorNum akepark:list){
                StaticResource.akeparkMap.put(akepark.getStation().getId()+","+akepark.getFloorNum(),akepark.getAkeparkFloor());
            }
        }
        if(StaticResource.cameraList.size()==0){
            StaticResource.cameraList.addAll(CameraIp.listAll(CameraIp.class));
        }

        if(StaticResource.perssionList.size()==0){
            StaticResource.perssionList.addAll(UserXPerssion.listAll(UserXPerssion.class));
        }

    }
}
