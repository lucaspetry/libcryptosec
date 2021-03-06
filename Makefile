LIBS = -lp11 
INCLUDES = -I/usr/local/ssl/include -I./include
FLAGS = -shared
CC = g++
EXECUTABLES = libcryptosec.so
ARQ= $(shell uname -m)
LIBDIR = /usr/lib

USER_OBJS += /usr/local/ssl/lib/libcrypto.a

CPP_SRCS += \
./src/AsymmetricCipher.cpp \
./src/AsymmetricKey.cpp \
./src/Base64.cpp \
./src/BigInteger.cpp \
./src/ByteArray.cpp \
./src/DSAKeyPair.cpp \
./src/DSAPrivateKey.cpp \
./src/DSAPublicKey.cpp \
./src/ECDSAKeyPair.cpp \
./src/ECDSAPrivateKey.cpp \
./src/ECDSAPublicKey.cpp \
./src/DateTime.cpp \
./src/DynamicEngine.cpp \
./src/Engine.cpp \
./src/Engines.cpp \
./src/Hmac.cpp \
./src/KeyPair.cpp \
./src/MessageDigest.cpp \
./src/NetscapeSPKI.cpp \
./src/NetscapeSPKIBuilder.cpp \
./src/OpenSSLErrorHandler.cpp \
./src/Pkcs7.cpp \
./src/Pkcs7Builder.cpp \
./src/Pkcs7CertificateBundle.cpp \
./src/Pkcs7CertificateBundleBuilder.cpp \
./src/Pkcs7EnvelopedData.cpp \
./src/Pkcs7EnvelopedDataBuilder.cpp \
./src/Pkcs7Factory.cpp \
./src/Pkcs7SignedData.cpp \
./src/Pkcs7SignedDataBuilder.cpp \
./src/Pkcs12.cpp \
./src/Pkcs12Factory.cpp \
./src/Pkcs12Builder.cpp \
./src/PrivateKey.cpp \
./src/PublicKey.cpp \
./src/RSAKeyPair.cpp \
./src/RSAPrivateKey.cpp \
./src/RSAPublicKey.cpp \
./src/Random.cpp \
./src/SecretSharer.cpp \
./src/Signer.cpp \
./src/SmartcardCertificate.cpp \
./src/SmartcardReader.cpp \
./src/SmartcardSlot.cpp \
./src/SmartcardSlots.cpp \
./src/SymmetricCipher.cpp \
./src/SymmetricKey.cpp \
./src/SymmetricKeyGenerator.cpp \
./src/certificate/AccessDescription.cpp \
./src/certificate/AuthorityKeyIdentifierExtension.cpp \
./src/certificate/AuthorityInformationAccessExtension.cpp \
./src/certificate/BasicConstraintsExtension.cpp \
./src/certificate/Certificate.cpp \
./src/certificate/CertificateBuilder.cpp \
./src/certificate/CertificatePoliciesExtension.cpp \
./src/certificate/CertificateRequest.cpp \
./src/certificate/CertificateRequestSPKAC.cpp \
./src/certificate/CertificateRequestFactory.cpp \
./src/certificate/CertificateRevocationList.cpp \
./src/certificate/CertificateRevocationListBuilder.cpp \
./src/certificate/CRLDistributionPointsExtension.cpp \
./src/certificate/CRLNumberExtension.cpp \
./src/certificate/DeltaCRLIndicatorExtension.cpp \
./src/certificate/DistributionPoint.cpp \
./src/certificate/DistributionPointName.cpp \
./src/certificate/ExtendedKeyUsageExtension.cpp \
./src/certificate/Extension.cpp \
./src/certificate/GeneralName.cpp \
./src/certificate/GeneralNames.cpp \
./src/certificate/IssuerAlternativeNameExtension.cpp \
./src/certificate/KeyUsageExtension.cpp \
./src/certificate/ObjectIdentifier.cpp \
./src/certificate/ObjectIdentifierFactory.cpp \
./src/certificate/PolicyInformation.cpp \
./src/certificate/PolicyQualifierInfo.cpp \
./src/certificate/RDNSequence.cpp \
./src/certificate/RevokedCertificate.cpp \
./src/certificate/SubjectAlternativeNameExtension.cpp \
./src/certificate/SubjectInformationAccessExtension.cpp \
./src/certificate/SubjectKeyIdentifierExtension.cpp \
./src/certificate/UserNotice.cpp \
./src/ec/EllipticCurve.cpp \
./src/ec/BrainpoolCurveFactory.cpp \
 
OBJS += $(CPP_SRCS:.cpp=.o)

CPP_DEPS += $(CPP_SRCS:.cpp=.d)

src/%.o: ./src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	$(CC) -fPIC $(INCLUDES) -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

$(EXECUTABLES):	$(OBJS)
	$(CC) -fPIC $(FLAGS) -o $(EXECUTABLES) $(OBJS) $(USER_OBJS) $(LIBS)  
	@echo 'Build complete!'

clean:
	rm -rf $(CPP_DEPS) $(OBJS) $(EXECUTABLES)
	

libdir:
ifeq ($(ARQ), x86_64)
	LIBDIR=/usr/lib64
endif

install: $(EXECUTABLES) libdir
	@echo 'Installing libcryptosec ...'
	@mkdir -p $(DESTDIR)$(LIBDIR)
	@cp libcryptosec.so $(DESTDIR)$(LIBDIR)
	@mkdir -m 0755 -p $(DESTDIR)/usr/include/libcryptosec
	@mkdir -m 0755 -p $(DESTDIR)/usr/include/libcryptosec/exception
	@mkdir -m 0755 -p $(DESTDIR)/usr/include/libcryptosec/certificate
	@mkdir -m 0755 -p $(DESTDIR)/usr/include/libcryptosec/ec
	@cp -f include/libcryptosec/*.h $(DESTDIR)/usr/include/libcryptosec/
	@cp -f include/libcryptosec/exception/* $(DESTDIR)/usr/include/libcryptosec/exception
	@cp -f include/libcryptosec/certificate/* $(DESTDIR)/usr/include/libcryptosec/certificate
	@cp -f include/libcryptosec/ec/* $(DESTDIR)/usr/include/libcryptosec/ec
	@echo 'Instalation complete!'

uninstall:
	@echo 'Uninstalling libcryptosec ...'
	@rm -rf $(DESTDIR)$(LIBDIR)/$(EXECUTABLES)
	@rm -rf $(DESTDIR)/usr/include/libcryptosec
	@echo 'Uninstalation complete!'
