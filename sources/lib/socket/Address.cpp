#include "Address.hpp"
#include <sstream>

Address::Address()
    : m_len(sizeof(m_addr))
{
    set_internet_family();
    set_port(0);
    set_any_host();
}

Address::~Address()
{
}

Address::Address(uint16_t port)
    : m_len(sizeof(m_addr))
{
    set_internet_family();
    set_port(port);
    set_any_host();
}

Address::Address(const std::string & host, uint16_t port)
    : m_len(sizeof(m_addr))
{
    set_internet_family();
    set_port(port);
    set_host(host);
}

Address::Address( const socket_address_type *addr, size_type len )
    : m_len(sizeof(m_addr))
{
     memcpy(&m_addr, addr, len);
}

void Address::set_host(const std::string & host )
{
    if( host.empty())
        set_any_host();
    else
        m_addr.sin_addr.s_addr = inet_addr( host.c_str() );
}

void Address::set_ipv4(const std::string & ipv4)
{
    if( ipv4.empty())
        set_any_host();
    else
        inet_aton(ipv4.c_str(), (struct in_addr *) &m_addr.sin_addr.s_addr);
}

struct sockaddr *
Address::get_addr()
{
    return (struct sockaddr*)&m_addr;
}

const struct sockaddr *
Address::get_addr() const
{
    return (struct sockaddr*)&m_addr;
}

Address::size_type *
Address::get_size_ptr()
{
    return &m_len;
}

Address::size_type
Address::get_size() const
{
    return m_len;
}

void Address::set_any_host()
{
    m_addr.sin_addr.s_addr = INADDR_ANY;
}

void Address::set_port( uint16_t port )
{
    m_addr.sin_port = htons(port);
}

void Address::set_internet_family()
{
    m_addr.sin_family = AF_INET;
}

Address::Address(const Address & rhs)
{
    assign(rhs);
}

Address & Address::operator=(const Address & rhs)
{
    assign(rhs);
    return *this;
}

void Address::assign(const Address & rhs)
{
    if(&rhs != this)
    {
        ::memcpy(&m_addr, &rhs.m_addr, rhs.m_len);
        m_len = rhs.m_len;
    }
}

std::string
Address::get_ip_address() const
{
    return ::inet_ntoa( m_addr.sin_addr );
}

std::string
Address::get_servicename() const
{
    std::stringstream ss;
    ss << ntohs(m_addr.sin_port);
    return ss.str();
}

std::ostream &
operator<<(std::ostream & out, const Address & addr)
{
    out << addr.get_ip_address() << ":" << addr.get_servicename();
    return out;
}
