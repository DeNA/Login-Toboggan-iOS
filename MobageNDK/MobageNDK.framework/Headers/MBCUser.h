//
//  MBCUser.h
//  mobage-ndk
//
//  Copyright (c) 2012, DeNA Co., Ltd. All rights reserved
//
//

#ifndef MBCUSER_H_
#define MBCUSER_H_

#include "MBCStandardTypes.h"
#include "MBCError.h"

#ifdef __cplusplus
extern "C" {
#endif

#pragma mark Enums / Bitfields

	#pragma mark Structs
	typedef struct {
		volatile int32_t __CAPI_REFCOUNT; // VERY INTERNAL
		void * __CAPI_NATIVEREF; // ALSO VERY INTERNAL
		
		MBC_Common_IsActive(const char * uid);
		MBC_Common_IsActive(const char * nickname);
		MBC_Common_IsActive(const char * displayName);
		MBC_Common_IsActive(const char * thumbnailUrl);
		MBC_Common_IsActive(const char * aboutMe);
		MBC_Common_IsActive(bool hasApp);
		MBC_Common_IsActive(int32_t age);
		MBC_Common_IsActive(int32_t grade);
		MBC_Common_IsActive(bool isFamous);
		MBC_JP_IsActive(const char * bloodType);
		MBC_JP_IsActive(bool isVerified);
		MBC_JP_IsActive(const char * jobType);
		MBC_JP_IsActive(const char * birthday);
		MBC_WW_IsActive(const char * firstName);
		MBC_WW_IsActive(const char * lastName);
		MBC_WW_IsActive(const char * relation);
		MBC_WW_IsActive(const char * gender);
		MBC_WW_IsActive(const char * phoneNumber);
		MBC_WW_IsActive(int32_t unreadWallPostCount);
		MBC_WW_IsActive(int32_t gamerScore);
		MBC_WW_IsActive(int32_t levelNumber);
		MBC_WW_IsActive(const char * levelName);
		MBC_WW_IsActive(int32_t currentLevelScore);
		MBC_WW_IsActive(int32_t nextLevelScore);
		MBC_WW_IsActive(int32_t sessionCount);
		MBC_WW_IsActive(bool isNuxComplete);
		MBC_WW_IsActive(bool isMobageUser);
		MBC_WW_IsActive(bool isGameHubUser);
		MBC_WW_IsActive(bool isNewBuddy);
		MBC_WW_IsActive(bool isMutualFriend);
		MBC_WW_IsActive(bool privacyFlag);
		MBC_WW_IsActive(bool mailOptInFlag);
		MBC_WW_IsActive(bool hidePresenceFlag);
		MBC_WW_IsActive(bool ignoreFriendRequestsFlag);
		MBC_WW_IsActive(bool onlyShowFriendNotifications);
		MBC_WW_IsActive(bool filterWallPostsToFriendsOnly);
	}  MBCUser;
	
	MBCArrayForType(User,MBCUser *);
	
	#pragma mark - Retain/Release (produces type-specific MBCRetain & MBCRelease)
	MBCRetainPrototype(User);
	MBCRetainPrototype(User_Array);
	MBCReleasePrototype(User);
	MBCReleasePrototype(User_Array);
	
	#pragma mark - Constructors
	/**
	 * Constructors return objects with a REFCOUNT of 1, you must call MBCRelease when you're done!
	 */
	MBCUser * MBCConstructUser(void * __CAPI_NATIVEREF);
	MBCUser_Array * MBCConstructUser_Array(void * __CAPI_NATIVEREF);
	
	MBCUser * MBCCopyConstructUser(MBCUser * foreignObject, bool shouldDeepCopy); // Copies object into C address-space
	MBCUser_Array * MBCCopyConstructUser_Array(MBCUser_Array * foreignObject, bool shouldCopyElements); // Copies object array into C address-space
	
	/**
	 * @private
	 * Fills a previously allocated struct (Internal)
	 */
	void MBCFillStructUser(void * structObj, void * __CAPI_NATIVEREF);
	void MBCFillStructUser_Array(void *structObj, void * __CAPI_NATIVEREF); 
	
	#pragma mark - Notifications
	// Has None!
	
	#pragma mark - Method Callbacks!
	
	#pragma mark - Static Methods
	// None!
	#pragma mark - Instance Methods
	// None!


#ifdef __cplusplus
}
#endif

#endif /* MBCUSER_H_ */

