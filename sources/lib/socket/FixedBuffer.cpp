#include "FixedBuffer.hpp"

FixedBuffer::FixedBuffer(size_t size)
    : m_buf(size,0)
    , m_avail(0)
    , m_written(0)
    , m_size(size)
{

}

FixedBuffer::~FixedBuffer(){}

FixedBuffer::FixedBuffer(const FixedBuffer & rhs)
{
    assign(rhs);
}

FixedBuffer &
FixedBuffer::operator=(const FixedBuffer & rhs)
{
    assign(rhs);
    return *this;
}


void FixedBuffer::assign(const FixedBuffer & rhs)
{
    if(this != &rhs)
    {
        m_buf     = rhs.m_buf;
        m_avail   = rhs.m_avail;
        m_written = rhs.m_written;
        m_size    = rhs.m_size;
    }
}

bool
FixedBuffer::is_write_possible() const
{
    return (m_avail < m_size);
}

bool
FixedBuffer::is_read_pending() const
{
    return (length() > 0);
}

bool
FixedBuffer::is_empty() const
{
    return (length() == 0);
}

char *
FixedBuffer::write_head()
{
    return &m_buf[0] + m_avail;
}

char *
FixedBuffer::read_head()
{
    return &m_buf[0] + m_written;
}

size_t
FixedBuffer::length() const
{
    return m_avail - m_written;
}

void
FixedBuffer::complete_write(size_t amount)
{
    m_avail += amount;
    if (m_written == m_avail)
        clear();
}

void
FixedBuffer::complete_read(size_t amount)
{
    m_written += amount;
    if (m_written == m_avail)
        clear();
}

size_t
FixedBuffer::capacity()
{
    return (m_size - m_avail);
}

void
FixedBuffer::clear()
{
    m_avail = m_written = 0;
}
