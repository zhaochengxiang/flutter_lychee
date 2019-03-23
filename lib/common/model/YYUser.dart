import 'package:json_annotation/json_annotation.dart';

part 'YYUser.g.dart';

@JsonSerializable()
class YYUser {
  double id;                               
  double sid;                             
  String token;     
  String phone;        
  String username;     
  double createTime;                       
  String avatar;                           
  int sex;                           
  String city;        
  int openBook;                      
  int bookQuantity;                  
  int libraryQuantity;               
  int clippingQuantity;              
  int friendQuantity;                
  int wantReadQuantity;              
  int haveReadQuantity;              
  int collectionQuantity;            
  int borrowedQuantity;              
  int borrowingQuantity;             
  int lentQuantity;                  
  int lendingQuantity;               
  int unreadMessageQuantity;         

  YYUser(
    this.id,                               
    this.sid,                             
    this.token,     
    this.phone,        
    this.username,    
    this.createTime,                       
    this.avatar,                          
    this.sex,                          
    this.city,        
    this.openBook,                      
    this.bookQuantity,                  
    this.libraryQuantity,               
    this.clippingQuantity,              
    this.friendQuantity,                
    this.wantReadQuantity,              
    this.haveReadQuantity,              
    this.collectionQuantity,            
    this.borrowedQuantity,              
    this.borrowingQuantity,            
    this.lentQuantity,                 
    this.lendingQuantity,              
    this.unreadMessageQuantity, 
  );

  factory YYUser.fromJson(Map<String, dynamic> json) => _$YYUserFromJson(json);

  Map<String, dynamic> toJson() => _$YYUserToJson(this);
}
