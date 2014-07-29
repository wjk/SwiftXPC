//
//  XPCTypeShims.h
//  DOS Prompt
//
//  Created by William Kent on 7/28/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

#import <Foundation/Foundation.h>

// SwiftXPCShims is required due to the ObjC-Swift bridge not exposing certain XPC APIs correctly.

#pragma mark Type Shims

extern xpc_type_t XPCShimGetConnectionType(void);
extern xpc_type_t XPCShimGetEndpointType(void);
extern xpc_type_t XPCShimGetActivityType(void);
extern xpc_type_t XPCShimGetNullType(void);
extern xpc_type_t XPCShimGetBooleanType(void);
extern xpc_type_t XPCShimGetInt64Type(void);
extern xpc_type_t XPCShimGetUInt64Type(void);
extern xpc_type_t XPCShimGetDoubleType(void);
extern xpc_type_t XPCShimGetDateType(void);
extern xpc_type_t XPCShimGetDataType(void);
extern xpc_type_t XPCShimGetStringType(void);
extern xpc_type_t XPCShimGetUUIDType(void);
extern xpc_type_t XPCShimGetFileDescriptorType(void);
extern xpc_type_t XPCShimGetSharedMemoryType(void);
extern xpc_type_t XPCShimGetArrayType(void);
extern xpc_type_t XPCShimGetDictionaryType(void);
extern xpc_type_t XPCShimGetErrorType(void);

#pragma mark Static Object Shims

extern xpc_object_t XPCShimGetConnectionInterruptedError(void);
extern xpc_object_t XPCShimGetConnectionInvalidError(void);
extern xpc_object_t XPCShimGetTerminationImminentError(void);

#pragma mark xpc_uuid

extern xpc_object_t XPCShimCreateObjectFromUUID(NSUUID *uuid);
extern NSUUID *XPCShimGetUUIDFromObject(xpc_object_t object);

#pragma mark xpc_shmem

extern unsigned char * XPCShimMapSharedMemoryRegion(xpc_object_t region, size_t *size);

#pragma mark xpc_main()

extern void __attribute__((noreturn)) XPCShimMain(void (^)(xpc_connection_t connection));
