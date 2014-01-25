#ifndef FUMA_LIBRARIES_SOCKET_ADDRESS_HPP
#define FUMA_LIBRARIES_SOCKET_ADDRESS_HPP

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string>


class Address
{
public:
    typedef struct sockaddr_in socket_address_type;
    typedef socklen_t size_type;

    Address();
    ~Address();

    explicit Address(uint16_t port);
    Address(const Address & rhs);

    Address( const std::string & host, uint16_t port);
    Address( const socket_address_type *addr, size_type len );

    void assign(const Address & rhs);
    Address & operator=(const Address & rhs);

    void set_any_host();
    void set_host(const std::string & host);
    void set_ipv4(const std::string & ipv4 );

    void set_port(uint16_t port);
    void set_internet_family();

    // write
    struct sockaddr *           get_addr();

    // read only
    const struct sockaddr *     get_addr() const;

    std::string                 get_ip_address() const;
    std::string                 get_servicename() const;

    size_type * get_size_ptr();
    size_type get_size() const;

    private:
    socket_address_type m_addr;
    size_type           m_len;
};

std::ostream &
operator<<(std::ostream & out, const Address & addr);

#endif /*ndef FUMA_LIBRARIES_SOCKET_ADDRESS_HPP */
