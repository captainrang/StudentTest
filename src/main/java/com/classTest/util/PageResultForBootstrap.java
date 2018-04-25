package com.classTest.util;

import java.util.List;

/**
 * @Description: 与bootstrap-table数据交互对象
 * @Author:SuiXinYang
 * @Date:2017-7-11 下午5:46:51
 */
public class PageResultForBootstrap<T> {

	private List<T> rows;
	private int total;
	public List<T> getRows() {
		return rows;
	}
	public void setRows(List<T> rows) {
		this.rows = rows;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
}
