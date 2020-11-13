function getRoadList (list,gameID) {
	let self = this;
	this.recordList = list;
	var list = list;
	let isChange = '';
	var ArrayList = [];
	var singleArr = [];
	var k=0;
	if(gameID==2){  //longhu
		for(let i=0;i<list.length;i++){
			if(i == 0){
				// this.formatListData(list[i],null,gameID)
			}else{
				// this.formatListData(list[i],list[i-1],gameID)
			}
			delete list[i].num;
			if(list[i].winner == '') {
				continue;
			}
			if(isChange == ''){
				if(list[i].winner=='和'){
					isChange = '';
				}else{
					singleArr.push(list[i]);
					isChange = list[i].winner;
				}
				continue;
			}
			if(list[i].winner == '和') {
				singleArr[singleArr.length-1].num?singleArr[singleArr.length-1].num+=1:singleArr[singleArr.length-1].num=1;
				let item = singleArr.pop();
				singleArr.push(item);
				continue;
			}
			if(isChange == list[i].winner ){
				singleArr.push(list[i]);

			}else{
				k++;
				ArrayList.push(singleArr);
				singleArr = [list[i]]
				isChange = list[i].winner;
			}
			// console.log(i , list[i],k)
		}
		ArrayList.push(singleArr);
	}
	if(gameID==1){  //百家乐
		for(let i=0;i<list.length;i++){
			delete list[i].num;
			if(list[i].game == "") {
				continue;
			}
			if(isChange == ''){
				if(list[i].game=='和'){
					isChange = '';
				}else{
					if(list[i].game=='庄')
						list[i].winner = '龙'
					if(list[i].game=='闲')
						list[i].winner = '虎'
					singleArr.push(list[i]);
					isChange = list[i].game;
				}
				continue;
			}
			if(list[i].game == '和') {
				singleArr[singleArr.length-1].num?singleArr[singleArr.length-1].num+=1:singleArr[singleArr.length-1].num=1;
				let item = singleArr.pop();
				singleArr.push(item);
				continue;
			}
			if(isChange == list[i].game ){
				if(list[i].game=='庄')
					list[i].winner = '龙'
				if(list[i].game=='闲')
					list[i].winner = '虎'
				singleArr.push(list[i]);

			}else{
				k++;
				ArrayList.push(singleArr);
				if(list[i].game=='庄')
					list[i].winner = '龙'
				if(list[i].game=='闲')
					list[i].winner = '虎'
				singleArr = [list[i]]
				isChange = list[i].game;
			}
			// console.log(i , list[i],k)
		}
		console.log(singleArr)
		ArrayList.push(singleArr);
	}
	let tempArray=[];
	let DYtempArray=[];
	let XLtempArray=[];
	let YYtempArray=[];
	let LtempArray=[];
	let HtempArray=[];

	let asodaosdiaos=[];
	for(let a=0;a<10;a++){

		let stempnull=[];
		let stempnull1=[];
		let stempnull2=[];
		let stempnull3=[];
		for (let b=0;b<6;b++){
			stempnull.push(null)
		}
		for (let b=0;b<6;b++){
			stempnull1.push(null)
		}
		for (let b=0;b<6;b++){
			stempnull2.push(null)
		}
		for (let b=0;b<6;b++){
			stempnull3.push(null)
		}
		tempArray.push(stempnull);
		DYtempArray.push(stempnull1);
		XLtempArray.push(stempnull2);
		YYtempArray.push(stempnull3);
		//asodaosdiaos.push(stempnull)
	}


	/*console.log(DYtempArray)
	console.log(XLtempArray)
	console.log(YYtempArray)*/

	let DYarraylist=[]
	let XLarraylist=[]
	let YYarraylist=[]

	let Dx=0
	let Dy=0
	let Dxt=0
	let Dyt=0
	let Xx=0
	let Xy=0
	let Xxt=0
	let Xyt=0
	let Yx=0
	let Yy=0
	let Yxt=0
	let Yyt=0

	let Cxt=0
	let Cyt=0

	let long    ={id:0,winner:"龙"}
	let hu      ={id:0,winner:"虎"}
	for(let a=0;a<ArrayList.length;a++){
		let s=[]
		let s1=[]
		let s2=[]
		let s3=[]
		for (let c=0;c<6;c++){
			s.push(null)
		}
		for (let c=0;c<6;c++){
			s1.push(null)
		}
		for (let c=0;c<6;c++){
			s2.push(null)
		}
		for (let c=0;c<6;c++){
			s3.push(null)
		}
		tempArray.push(s)
		DYtempArray.push(s1)
		XLtempArray.push(s2)
		YYtempArray.push(s3)
		let g=0
		let gindex=0
		// console.log('a=',a)
		// console.log(tempArray)
		for(let b=0;b<ArrayList[a].length;b++){
			if(b>0){
				console.log(11111)
				if(gindex>0){
					g++;
					tempArray[a+g][gindex]=ArrayList[a][b];
					Cxt=a+g
					Cyt=gindex

				}else{
					if(tempArray[a][b]!=null||b>5){
						
						gindex=b-1
						g++;
						// console.log(tempArray)
						// console.log("a=",a+g,"b=",gindex)
						tempArray[a+g][gindex]=ArrayList[a][b];
						Cxt=a+g
						Cyt=gindex
					}else{
						tempArray[a][b]=ArrayList[a][b];
						Cxt=a
						Cyt=b
					}
				}
			}else{
				tempArray[a][b]=ArrayList[a][b];
				Cxt=a
				Cyt=b
				//console.log(tempArray[a][b]);
			}
			//开始大眼仔问路
			if((a>0&&b>0)||a>1){
				if(b==0){
					//判断齐整
					if(ArrayList[a-1].length==ArrayList[a-2].length){
						//齐整 红

						if(Dy==0){
							DYtempArray[Dx][Dy]=long
							Dy++

						}else{
							if(DYtempArray[Dx][Dy-1]!= null && long.winner==DYtempArray[Dx][Dy-1].winner){//结果相同 向下走
								if(DYtempArray[Dx][Dy]!=null||Dy>5){
									if(Dyt>0){
										Dxt++
										DYtempArray[Dxt][Dyt]=long
									}else{
										Dxt=Dx+1
										Dyt=Dy-1
										DYtempArray[Dxt][Dyt]=long
									}

								}else{
									DYtempArray[Dx][Dy]=long
									Dy++

								}
							}else{
								//换行
								Dx++;
								Dy=0
								Dxt=0
								Dyt=0
								DYtempArray[Dx][Dy]=long
								Dy++
							}

						}
					}else{
						//蓝
						if(Dy==0){
							DYtempArray[Dx][Dy]=hu
							Dy++

						}else{
							if(DYtempArray[Dx][Dy-1]!=null && hu.winner==DYtempArray[Dx][Dy-1].winner){//结果相同 向下走
								if(DYtempArray[Dx][Dy]!=null||Dy>5){
									if(Dyt>0){
										Dxt++
										DYtempArray[Dxt][Dyt]=hu
									}else{
										Dxt=Dx+1
										Dyt=Dy-1
										DYtempArray[Dxt][Dyt]=hu
									}

								}else{
									DYtempArray[Dx][Dy]=hu
									Dy++

								}
							}else{
								//换行
								Dx++;
								Dy=0
								Dxt=0
								Dyt=0
								DYtempArray[Dx][Dy]=hu
								Dy++
							}

						}

					}
				}else {
					if(tempArray[a-1][b]!=null){
						// 有无 有 红
						if(Dy==0){
							DYtempArray[Dx][Dy]=long
							Dy++

						}else{
							if(DYtempArray[Dx][Dy-1]!=null && long.winner==DYtempArray[Dx][Dy-1].winner){//结果相同 向下走
								if(DYtempArray[Dx][Dy]!=null||Dy>5){
									if(Dyt>0){
										Dxt++
										DYtempArray[Dxt][Dyt]=long
									}else{
										Dxt=Dx+1
										Dyt=Dy-1
										DYtempArray[Dxt][Dyt]=long
									}

								}else{
									DYtempArray[Dx][Dy]=long
									Dy++

								}
							}else{
								//换行
								Dx++;
								Dy=0
								Dxt=0
								Dyt=0
								DYtempArray[Dx][Dy]=long
								Dy++
							}

						}

					}else{
						if(tempArray[a-1][b-1]==null){
							//直落 红
							if(Dy==0){
								DYtempArray[Dx][Dy]=long
								Dy++

							}else{
								if(DYtempArray[Dx][Dy-1]!=null && long.winner==DYtempArray[Dx][Dy-1].winner){//结果相同 向下走
									if(DYtempArray[Dx][Dy]!=null||Dy>5){
										if(Dyt>0){
											Dxt++
											DYtempArray[Dxt][Dyt]=long
										}else{
											Dxt=Dx+1
											Dyt=Dy-1
											DYtempArray[Dxt][Dyt]=long
										}

									}else{
										DYtempArray[Dx][Dy]=long
										Dy++

									}
								}else{
									//换行
									Dx++;
									Dy=0
									Dxt=0
									Dyt=0
									DYtempArray[Dx][Dy]=long
									Dy++
								}

							}

						}else{
							// 有无 无 蓝
							if(Dy==0){
								DYtempArray[Dx][Dy]=hu
								Dy++

							}else{
								if(DYtempArray[Dx][Dy-1]!=null && hu.winner==DYtempArray[Dx][Dy-1].winner){//结果相同 向下走
									if(DYtempArray[Dx][Dy]!=null||Dy>5){
										if(Dyt>0){
											Dxt++
											DYtempArray[Dxt][Dyt]=hu
										}else{
											Dxt=Dx+1
											Dyt=Dy-1
											DYtempArray[Dxt][Dyt]=hu
										}

									}else{
										DYtempArray[Dx][Dy]=hu
										Dy++

									}
								}else{
									//换行
									Dx++;
									Dy=0
									Dxt=0
									Dyt=0
									DYtempArray[Dx][Dy]=hu
									Dy++
								}

							}
						}
					}
				}
				if((a>1&&b>0)||a>2){

					//小路
					if(b==0){
						//判断齐整
						if(ArrayList[a-1].length==ArrayList[a-3].length){
							//齐整 红
							// console.log("q红")
							if(Xy==0){
								XLtempArray[Xx][Xy]=long
								Xy++

							}else{
								if(XLtempArray[Xx][Xy-1]!= null && long.winner==XLtempArray[Xx][Xy-1].winner){//结果相同 向下走
									if(XLtempArray[Xx][Xy]!=null||Xy>5){
										if(Xyt>0){
											Xxt++
											XLtempArray[Xxt][Xyt]=long
										}else{
											Xxt=Xx+1
											Xyt=Xy-1
											XLtempArray[Xxt][Xyt]=long
										}

									}else{
										XLtempArray[Xx][Xy]=long
										Xy++

									}
								}else{
									//换行
									Xx++;
									Xy=0
									Xxt=0
									Xyt=0
									XLtempArray[Xx][Xy]=long
									Xy++
								}

							}
						}else{
							//蓝
							// console.log("q蓝")
							if(Xy==0){
								XLtempArray[Xx][Xy]=hu
								Xy++

							}else{
								if(XLtempArray[Xx][Xy-1]!=null && hu.winner==XLtempArray[Xx][Xy-1].winner){//结果相同 向下走
									if(XLtempArray[Xx][Xy]!=null||Xy>5){
										if(Xyt>0){
											Xxt++
											XLtempArray[Xxt][Xyt]=hu
										}else{
											Xxt=Xx+1
											Xyt=Xy-1
											XLtempArray[Xxt][Xyt]=hu
										}

									}else{
										XLtempArray[Xx][Xy]=hu
										Xy++

									}
								}else{
									//换行
									Xx++;
									Xy=0
									Xxt=0
									Xyt=0
									XLtempArray[Xx][Xy]=hu
									Xy++
								}

							}
						}
					}else{
						if(tempArray[a-2][b]!=null){
							// 有无 有 红
							// console.log("y红")
							if(Xy==0){
								XLtempArray[Xx][Xy]=long
								Xy++

							}else{
								if(XLtempArray[Xx][Xy-1]!=null && long.winner==XLtempArray[Xx][Xy-1].winner){//结果相同 向下走
									if(XLtempArray[Xx][Xy]!=null||Xy>5){
										if(Xyt>0){
											Xxt++
											XLtempArray[Xxt][Xyt]=long
										}else{
											Xxt=Xx+1
											Xyt=Xy-1
											XLtempArray[Xxt][Xyt]=long
										}

									}else{
										XLtempArray[Xx][Xy]=long
										Xy++
									}
								}else{
									//换行
									Xx++;
									Xy=0
									Xxt=0
									Xyt=0
									XLtempArray[Xx][Xy]=long
									Xy++
								}

							}
						}else{
							if(tempArray[a-2][b-1]==null){
								//直落 红
								// console.log("z红")
								if(Xy==0){
									XLtempArray[Xx][Xy]=long
									Xy++

								}else{
									if(XLtempArray[Xx][Xy-1]!=null && long.winner==XLtempArray[Xx][Xy-1].winner){//结果相同 向下走
										if(XLtempArray[Xx][Xy]!=null||Xy>5){
											if(Xyt>0){
												Xxt++
												XLtempArray[Xxt][Xyt]=long
											}else{
												Xxt=Xx+1
												Xyt=Xy-1
												XLtempArray[Xxt][Xyt]=long
											}

										}else{
											XLtempArray[Xx][Xy]=long
											Xy++
										}
									}else{
										//换行
										Xx++;
										Xy=0
										Xxt=0
										Xyt=0
										XLtempArray[Xx][Xy]=long
										Xy++
									}

								}
							}else{
								// 有无 无 蓝
								// console.log("y蓝")
								if(Xy==0){
									XLtempArray[Xx][Xy]=hu
									Xy++

								}else{
									if(XLtempArray[Xx][Xy-1]!=null && hu.winner==XLtempArray[Xx][Xy-1].winner){//结果相同 向下走
										if(XLtempArray[Xx][Xy]!=null||Xy>5){
											if(Xyt>0){
												Xxt++
												XLtempArray[Xxt][Xyt]=hu
											}else{
												Xxt=Xx+1
												Xyt=Xy-1
												XLtempArray[Xxt][Xyt]=hu
											}

										}else{
											XLtempArray[Xx][Xy]=hu
											Xy++

										}
									}else{
										//换行
										Xx++;
										Xy=0
										Xxt=0
										Xyt=0
										XLtempArray[Xx][Xy]=hu
										Xy++
									}

								}
							}
						}
					}

					if((a>2&&b>0)||a>3){
						// console.log(YYtempArray);
						//由于路
						if(b==0){
							//判断齐整
							if(ArrayList[a-1].length==ArrayList[a-4].length){
								//齐整 红
								//console.log("q红")
								if(Yy==0){
									YYtempArray[Yx][Yy]=long
									Yy++

								}else{
									if(YYtempArray[Yx][Yy-1]!= null && long.winner==YYtempArray[Yx][Yy-1].winner){//结果相同 向下走
										if(YYtempArray[Yx][Yy]!=null||Yy>5){
											if(Yyt>0){
												Yxt++
												YYtempArray[Yxt][Yyt]=long
											}else{
												Yxt=Yx+1
												Yyt=Yy-1
												YYtempArray[Yxt][Yyt]=long
											}

										}else{
											YYtempArray[Yx][Yy]=long
											Yy++

										}
									}else{
										//换行
										Yx++;
										Yy=0
										Yxt=0
										Yyt=0
										YYtempArray[Yx][Yy]=long
										Yy++
									}

								}
							}else{
								//蓝
								if(Yy==0){
									YYtempArray[Yx][Yy]=hu
									Yy++

								}else{
									if(YYtempArray[Yx][Yy-1]!= null && hu.winner==YYtempArray[Yx][Yy-1].winner){//结果相同 向下走
										if(YYtempArray[Yx][Yy]!=null||Yy>5){
											if(Yyt>0){
												Yxt++
												YYtempArray[Yxt][Yyt]=hu
											}else{
												Yxt=Yx+1
												Yyt=Yy-1
												YYtempArray[Yxt][Yyt]=hu
											}

										}else{
											YYtempArray[Yx][Yy]=hu
											Yy++

										}
									}else{
										//换行
										Yx++;
										Yy=0
										Yxt=0
										Yyt=0
										YYtempArray[Yx][Yy]=hu
										Yy++
									}

								}
								// console.log(DYtempArray)
							}
						}else{
							if(tempArray[a-3][b]!=null){
								// 有无 有 红
								//console.log("y红")
								if(Yy==0){
									YYtempArray[Yx][Yy]=long
									Yy++

								}else{
									if(YYtempArray[Yx][Yy-1]!= null && long.winner==YYtempArray[Yx][Yy-1].winner){//结果相同 向下走
										if(YYtempArray[Yx][Yy]!=null||Yy>5){
											if(Yyt>0){
												Yxt++
												YYtempArray[Yxt][Yyt]=long
											}else{
												Yxt=Yx+1
												Yyt=Yy-1
												YYtempArray[Yxt][Yyt]=long
											}

										}else{
											YYtempArray[Yx][Yy]=long
											Yy++

										}
									}else{
										//换行
										Yx++;
										Yy=0
										Yxt=0
										Yyt=0
										YYtempArray[Yx][Yy]=long
										Yy++
									}

								}
							}else{
								if(tempArray[a-3][b-1]==null){
									//直落 红
									//console.log("z红")
									if(Yy==0){
										YYtempArray[Yx][Yy]=long
										Yy++

									}else{
										if(YYtempArray[Yx][Yy-1]!= null && long.winner==YYtempArray[Yx][Yy-1].winner){//结果相同 向下走
											if(YYtempArray[Yx][Yy]!=null||Yy>5){
												if(Yyt>0){
													Yxt++
													YYtempArray[Yxt][Yyt]=long
												}else{
													Yxt=Yx+1
													Yyt=Yy-1
													YYtempArray[Yxt][Yyt]=long
												}

											}else{
												YYtempArray[Yx][Yy]=long
												Yy++

											}
										}else{
											//换行
											Yx++;
											Yy=0
											Yxt=0
											Yyt=0
											YYtempArray[Yx][Yy]=long
											Yy++
										}

									}
								}else{
									// 有无 无 蓝
									//console.log("y蓝")
									if(Yy==0){
										YYtempArray[Yx][Yy]=hu
										Yy++

									}else{
										if(YYtempArray[Yx][Yy-1]!= null && hu.winner==YYtempArray[Yx][Yy-1].winner){//结果相同 向下走
											if(YYtempArray[Yx][Yy]!=null||Yy>5){
												if(Yyt>0){
													Yxt++
													YYtempArray[Yxt][Yyt]=hu
												}else{
													Yxt=Yx+1
													Yyt=Yy-1
													YYtempArray[Yxt][Yyt]=hu
												}

											}else{
												YYtempArray[Yx][Yy]=hu
												Yy++

											}
										}else{
											// console.log(YYtempArray)
											//换行
											Yx++;
											Yy=0
											Yxt=0
											Yyt=0
											YYtempArray[Yx][Yy]=hu
											Yy++
										}

									}
								}
							}
						}
					}
				}
			}


			if(a==ArrayList.length-1 && b==ArrayList[a].length-1){
				//定位大陆的位置

				if(a==0&&b==0){
					LtempArray.push(null)
					LtempArray.push(null)
					LtempArray.push(null)
					HtempArray.push(null)
					HtempArray.push(null)
					HtempArray.push(null)

				}else{

					// console.log("开始定位大路")
					// console.log("x:",a,"y",b)
					//新的是龙的情况
					var LongX
					var LongY
					var HuX
					var HuY

					if(ArrayList[a][b].winner==long.winner){//相同向下 不同另起一行
						if(tempArray[Cxt][Cyt+1]!=null || Cyt+1>5){
							if(gindex>0){
								LongX=Cxt+1
								LongY=Cyt
							}else{
								LongX=Cxt+1
								LongY=Cyt
							}

						}else{

							LongX=Cxt
							LongY=Cyt+1
						}
					}else{

						LongX=a+1
						LongY=0
					}
					console.log("龙问路","x:",LongX,"y",LongY)
					// console.log("x:",LongX,"y",LongY)
					if(LongY==0){
						//判断齐整
						if(LongX>1){
							if(ArrayList[LongX-1].length==ArrayList[LongX-2].length){
								LtempArray.push(long)
							}else{
								LtempArray.push(hu)
							}
						}else{
							LtempArray.push(null)
						}
						if(LongX>2){
							if(ArrayList[LongX-1].length==ArrayList[LongX-3].length){
								LtempArray.push(long)
							}else{
								LtempArray.push(hu)
							}
						}else{
							LtempArray.push(null)
						}
						if(LongX>3){
							if(ArrayList[LongX-1].length==ArrayList[LongX-3].length){
								LtempArray.push(long)
							}else{
								LtempArray.push(hu)
							}
						}else{
							LtempArray.push(null)
						}
					}
					else{
						if(LongX>0){
							if(tempArray[LongX-1][LongY]!=null){
								LtempArray.push(long)
							}else{
								if(tempArray[LongX-1][LongY-1]!=null){
									LtempArray.push(hu)
								}else{
									LtempArray.push(long)
								}
							}
						}else{
							LtempArray.push(null)
						}
						if(LongX>1){
							if(tempArray[LongX-2][LongY]!=null){
								LtempArray.push(long)
							}else{
								if(tempArray[LongX-2][LongY-1]!=null){
									LtempArray.push(hu)
								}else{
									LtempArray.push(long)
								}
							}
						}else{
							LtempArray.push(null)
						}
						if(LongX>2){
							if(tempArray[LongX-3][LongY]!=null){
								LtempArray.push(long)
							}else{
								if(tempArray[LongX-3][LongY-1]!=null){
									LtempArray.push(hu)
								}else{
									LtempArray.push(long)
								}
							}
						}else{
							LtempArray.push(null)
						}
					}
					//新的是虎的情况


					LongX=0
					LongY=0
					if(ArrayList[a][b].winner==hu.winner){//相同向下 不同另起一行
						if(tempArray[Cxt][Cyt+1]!=null || Cyt+1>5){
							if(gindex>0){
								LongX=Cxt+1
								LongY=Cyt
							}else{
								LongX=Cxt+1
								LongY=Cyt
							}

						}else{

							LongX=Cxt
							LongY=Cyt+1
						}
					}else{

						LongX=a+1
						LongY=0
					}
					console.log("虎问路","x:",LongX,"y",LongY)
					// console.log("x:",LongX,"y",LongY)
					if(LongY==0){
						//判断齐整
						if(LongX>1){
							if(ArrayList[LongX-1].length==ArrayList[LongX-2].length){
								HtempArray.push(long)
							}else{
								HtempArray.push(hu)
							}
						}else{
							HtempArray.push(null)
						}
						if(LongX>2){
							if(ArrayList[LongX-1].length==ArrayList[LongX-3].length){
								HtempArray.push(long)
							}else{
								HtempArray.push(hu)
							}
						}else{
							HtempArray.push(null)
						}
						if(LongX>3){
							if(ArrayList[LongX-1].length==ArrayList[LongX-4].length){
								HtempArray.push(long)
							}else{
								HtempArray.push(hu)
							}
						}else{
							HtempArray.push(null)
						}
					}
					else{
						if(LongX>0){
							if(tempArray[LongX-1][LongY]!=null){
								HtempArray.push(long)
							}else{
								if(tempArray[LongX-1][LongY-1]!=null){
									HtempArray.push(hu)
								}else{
									HtempArray.push(long)
								}
							}
						}else{
							HtempArray.push(null)
						}
						if(LongX>1){
							if(tempArray[LongX-2][LongY]!=null){
								HtempArray.push(long)
							}else{
								if(tempArray[LongX-2][LongY-1]!=null){
									HtempArray.push(hu)
								}else{
									HtempArray.push(long)
								}
							}
						}else{
							HtempArray.push(null)
						}
						if(LongX>2){
							if(tempArray[LongX-3][LongY]!=null){
								HtempArray.push(long)
							}else{
								if(tempArray[LongX-3][LongY-1]!=null){
									HtempArray.push(hu)
								}else{
									HtempArray.push(long)
								}
							}
						}else{
							HtempArray.push(null)
						}
					}
				}

			}
		}
	}
    removeLast(tempArray)
    removeLast(DYtempArray)
    removeLast(XLtempArray)
    removeLast(YYtempArray)

	return {temp:tempArray, DYtemp:DYtempArray, XLtemp:XLtempArray, YYtemp:YYtempArray,L:LtempArray,H:HtempArray}
}

function removeLast(a) {
    console.log("aaaaaaa")
    let sign=true
    let i=a.length-1
    let index=0

    while (sign){
        if(!a[i]) return;
        for(let s=0;s<a[i].length;s++){
            if(a[i][s]!=null){
                sign=false;
                index=i;
                break;
            }
        }
        i--
    }
    a.splice(index+1)
    // cc.log(a)
    return index+1;
}
