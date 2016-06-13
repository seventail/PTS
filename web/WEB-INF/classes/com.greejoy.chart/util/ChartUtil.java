package com.greejoy.chart.util;

import com.greejoy.car.domain.CarFloor;
import org.apache.struts2.ServletActionContext;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.labels.ItemLabelAnchor;
import org.jfree.chart.labels.ItemLabelPosition;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.renderer.category.StackedBarRenderer;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.ui.TextAnchor;

import java.awt.*;
import java.io.File;
import java.util.*;

/**
 * Created by IntelliJ IDEA.
 * User: CZJiang
 * Date: 15-10-27
 * Time: 下午2:08
 * To change this template use File | Settings | File Templates.
 */
public class ChartUtil {
    JFreeChart chart;
    public JFreeChart getChartImg(java.util.List<CarFloor> carFloorList){
        CategoryDataset dataset = getDataSet(carFloorList);
        chart = ChartFactory.createBarChart(
                "停车位统计", // 图表标题
                "", // 目录轴的显示标签
                "停车位", // 数值轴的显示标签
                dataset, // 数据集
                PlotOrientation.VERTICAL, // 图表方向：水平、垂直
                true,           // 是否显示图例(对于简单的柱状图必须是false)
                false,          // 是否生成工具
                false           // 是否生成URL链接
        );
        //从这里开始
        CategoryPlot plot=chart.getCategoryPlot();//获取图表区域对象
        CategoryAxis domainAxis=plot.getDomainAxis();         //水平底部列表
        domainAxis.setLabelFont(new Font("黑体", Font.BOLD, 14));         //水平底部标题
        domainAxis.setTickLabelFont(new Font("宋体", Font.BOLD, 12));  //垂直标题
        ValueAxis rangeAxis=plot.getRangeAxis();//获取柱状
        rangeAxis.setLabelFont(new Font("黑体", Font.BOLD, 15));
        BarRenderer customBarRenderer = (BarRenderer) plot.getRenderer();
        customBarRenderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());//显示每个柱的数值
        customBarRenderer.setBaseItemLabelsVisible(true);
        //注意：此句很关键，若无此句，那数字的显示会被覆盖，给人数字没有显示出来的问题
        customBarRenderer.setBasePositiveItemLabelPosition(new ItemLabelPosition(
                ItemLabelAnchor.OUTSIDE12, TextAnchor.BASELINE_CENTER));
        customBarRenderer.setItemLabelAnchorOffset(3D);// 设置柱形图上的文字偏离值
        customBarRenderer.setSeriesPaint(0, Color.decode("#5555FF"));
        customBarRenderer.setSeriesPaint(1, Color.decode("#FF5555"));
        chart.getLegend().setItemFont(new Font("黑体", Font.BOLD, 15));
        chart.getTitle().setFont(new Font("宋体", Font.BOLD, 20));//设置标题字体
        return chart;
        //到这里结束，虽然代码有点多，但只为一个目的，解决汉字乱码问题

        //frame1=new ChartPanel(chart,true);        //这里也可以用chartFrame,可以直接生成一个独立的Frame
    }
    public  CategoryDataset getDataSet(java.util.List<CarFloor> carFloorList){
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        for(CarFloor carFloor:carFloorList){
            dataset.addValue(carFloor.getParking_lot() - carFloor.getLeftseats(), "已停车位", carFloor.getFloor_num() + "楼");
            dataset.addValue(carFloor.getLeftseats(), "未停车位", carFloor.getFloor_num()+"楼");
        }
        return dataset;
    }
    public JFreeChart getChartDate(Map<String,Integer> map,int flag){
        CategoryDataset dataset = setDate(map,flag);
        chart = ChartFactory.createBarChart(
                "停车次数统计", // 图表标题
                "", // 目录轴的显示标签
                "停车次数", // 数值轴的显示标签
                dataset, // 数据集
                PlotOrientation.VERTICAL, // 图表方向：水平、垂直
                true,           // 是否显示图例(对于简单的柱状图必须是false)
                false,          // 是否生成工具
                false           // 是否生成URL链接
        );
        //从这里开始
        CategoryPlot plot=chart.getCategoryPlot();//获取图表区域对象
        CategoryAxis domainAxis=plot.getDomainAxis();         //水平底部列表
        domainAxis.setLabelFont(new Font("黑体", Font.BOLD, 14));         //水平底部标题
        domainAxis.setTickLabelFont(new Font("宋体", Font.BOLD, 12));  //垂直标题
        ValueAxis rangeAxis=plot.getRangeAxis();//获取柱状
        rangeAxis.setLabelFont(new Font("黑体", Font.BOLD, 15));
        BarRenderer customBarRenderer = (BarRenderer) plot.getRenderer();
        customBarRenderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());//显示每个柱的数值
        customBarRenderer.setBaseItemLabelsVisible(true);
        //注意：此句很关键，若无此句，那数字的显示会被覆盖，给人数字没有显示出来的问题
        customBarRenderer.setBasePositiveItemLabelPosition(new ItemLabelPosition(
                ItemLabelAnchor.OUTSIDE12, TextAnchor.BASELINE_CENTER));
        customBarRenderer.setItemLabelAnchorOffset(3D);// 设置柱形图上的文字偏离值
        customBarRenderer.setSeriesPaint(0, Color.decode("#5555FF"));
        customBarRenderer.setMaximumBarWidth(0.04);
        customBarRenderer.setItemMargin(0.04);
        chart.getLegend().setItemFont(new Font("黑体", Font.BOLD, 15));
        chart.getTitle().setFont(new Font("宋体", Font.BOLD, 20));//设置标题字体
        return chart;
        //到这里结束，虽然代码有点多，但只为一个目的，解决汉字乱码问题

        //frame1=new ChartPanel(chart,true);        //这里也可以用chartFrame,可以直接生成一个独立的Frame
    }
    public  CategoryDataset setDate(Map<String,Integer> map,int flag){
        String str="";
        if(flag==0){
            str="按月";
        } else {
            str="按天";
        }
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        for(Map.Entry<String,Integer> entry:map.entrySet()){
            dataset.addValue(entry.getValue(),str, entry.getKey());
        }
        return dataset;
    }

    public void deleteFile(){
        File dirFile= new File(ServletActionContext.getServletContext().getRealPath("/") + "images/company/");
        File[] files = dirFile.listFiles();
        for (int i = 0; i < files.length; i++) {
            File file=new File(files[i].getAbsolutePath());
            if (file.isFile() && file.exists()) {
                file.delete();
            }
        }
    }
}
